# Biblioteki
from ctypes import windll
import tkinter as tk
from tkinter import messagebox
import threading
import time, random, math
import pandas as pd
import numpy as np
from scipy.io import wavfile
from matplotlib.figure import Figure
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
import win32com.client

# Zmienne
czas_start = None
czas_koniec = None
dane = []
czestotliwosc_probkowania = 100  # Częstotliwość próbkowania
czas_pomiaru = 0  # Czas pomiaru
odstep_probkowania = 1 / czestotliwosc_probkowania  # Odstęp próbkowania
dane_csv = None
indeks_csv = 0

# Dodatkowe zmienne do sterowania symulacją
czy_pauza = False
aktualny_indeks = 0  # Śledzi aktualny indeks dla przewijania wstecz/do przodu
czas_pauzy = 0.0
czas_ostatniej_pauzy = None
predkosc = 1.0  # współczynnik prędkości odtwarzania (1.0 = real time)

# Załaduj dane z pliku .CSV
if dane_csv is None:
    dane_csv = pd.read_csv('sensor_data.csv')  

# Funkcja rozpoczynająca pomiar
def rozpocznij_pomiar():
    global czas_start, czas_koniec, aktualny_indeks, czy_pauza, czas_pauzy, czas_ostatniej_pauzy, predkosc
    czas_start = time.time()
    czas_koniec = None
    aktualny_indeks = 0
    czy_pauza = False
    czas_pauzy = 0.0  # całkowity czas spędzony w pauzie
    czas_ostatniej_pauzy = None
    przycisk_start.config(state=tk.DISABLED)
    przycisk_reset.config(state=tk.DISABLED)  # reset nie działa podczas pracy symulacji

    # Oblicz całkowity czas trwania z pliku CSV
    if dane_csv is not None:
        calkowity_czas = dane_csv['Czas [s]'].iloc[-1]  # Ostatni znacznik czasu w pliku .CSV
    else:
        messagebox.showerror("Błąd", "Nie można odczytać czasu trwania z pliku CSV.")
        przycisk_start.config(state=tk.NORMAL)
        return

    def pomiar():
        global aktualny_indeks, dane, czas_pauzy, czas_ostatniej_pauzy, czas_koniec
        while True:
            # jeśli osiągnęliśmy koniec danych -> zatrzymaj
            if aktualny_indeks >= len(dane_csv):
                zatrzymaj_pomiar()
                break

            if czy_pauza:
                # podczas pauzy nie zwiększamy 'symulowanego' czasu
                time.sleep(0.05)
                continue

            # oblicz upłynięty czas symulacji (pomijając czas pauzy) i zastosuj współczynnik prędkości
            elapsed_sim = (time.time() - czas_start - czas_pauzy) * predkosc

            # docelowy timestamp z CSV
            target_t = dane_csv['Czas [s]'].iloc[aktualny_indeks]

            # czekaj aż upłynie do docelowego timestampu (real-time alignment)
            if elapsed_sim < target_t:
                # spać krótkimi odcinkami, żeby być responsywnym na pauzę
                time.sleep(min(0.02, target_t - elapsed_sim))
                continue

            # dodaj punkt (już nadszedł jego czas)
            t = target_t
            wartosc = dane_csv['Wartość [V]'].iloc[aktualny_indeks]
            dane.append((t, wartosc))
            aktualny_indeks += 1

            # aktualizuj wykres co kilka punktów (lub zawsze, zależnie od wydajności)
            if aktualny_indeks % 5 == 0 or aktualny_indeks == len(dane_csv):
                aktualizuj_wykres(dane)

            # jeśli ostatni timestamp przekracza całkowity czas -> zatrzymaj (bez pętli)
            if t >= calkowity_czas:
                zatrzymaj_pomiar()
                break

    threading.Thread(target=pomiar, daemon=True).start()

# Funkcja zatrzymująca pomiar
def zatrzymaj_pomiar():
    global czas_koniec, czas_pomiaru
    czas_koniec = time.time()
    czas_pomiaru = czas_koniec - czas_start if czas_start is not None else 0
    messagebox.showinfo("Symulacja zakończona", f"Symulacja zakończona pomyślnie.")
    # po zakończeniu pozwól na restart/reset
    przycisk_start.config(state=tk.NORMAL)
    przycisk_reset.config(state=tk.NORMAL)

# Funkcja resetująca wykres
def resetuj_wykres():
    os.clear()
    os.set_title("Rozpocznij symulację")
    os.set_xlabel("Czas [s]")
    os.set_ylabel("Wartość [V]")
    os.grid(True)
    canvas.draw()

# Funkcja resetująca pomiar
def resetuj_pomiar():
    global czas_start, czas_koniec, dane
    czas_start = None
    czas_koniec = None
    dane = []
    resetuj_wykres()
    messagebox.showinfo("Reset", "Pomiar został zresetowany.")
    przycisk_start.config(state=tk.NORMAL)

# Funkcja symulująca dane z sensora
def symulacja_sensora():
    global dane_csv, indeks_csv
    if dane_csv is None:
        try:
            dane_csv = pd.read_csv('sensor_data.csv')
            if 'Wartość [V]' not in dane_csv.columns:
                raise ValueError("Plik CSV musi zawierać kolumnę 'Wartość [V]'.")
        except Exception as e:
            messagebox.showerror("Błąd", f"Nie można załadować pliku CSV: {e}")
            return 0
    if indeks_csv < len(dane_csv):
        wartosc = dane_csv['Wartość [V]'].iloc[indeks_csv]
        indeks_csv += 1
        return wartosc
    else:
        indeks_csv = 0
        return dane_csv['Wartość [V]'].iloc[indeks_csv]

# Funkcja aktualizująca wykres
def aktualizuj_wykres(dane):
    # zachowaj poprzedni zakres x (szerokość okna) jeśli użytkownik zmienił zoom/przewinięcie
    if not dane:
        return
    x = [punkt[0] for punkt in dane]
    y = [punkt[1] for punkt in dane]

    try:
        prev_xlim = os.get_xlim()
        prev_width = prev_xlim[1] - prev_xlim[0]
        if not (prev_width and prev_width > 0):
            prev_width = 0.0
    except Exception:
        prev_width = 0.0

    # określ szerokość okna:
    # ale ograniczamy maksimum żeby nie pokazać zbyt dużego zakresu
    min_window = 20.0         # minimalna szerokość okna (zwiększona z 5)
    auto_scale_factor = 0.5   # część całkowitego czasu danych, którą pokażemy
    max_window = 120.0        # maksymalna szerokość okna

    dynamic_width = max(prev_width, min_window, (x[-1] - x[0]) * auto_scale_factor)
    szerokosc_okna = min(dynamic_width, max_window)

    os.clear()
    os.plot(x, y, color='blue')
    os.set_title("Sygnał pomiarowy")
    os.set_xlabel("Czas [s]")
    os.set_ylabel("Wartość [V]")
    os.grid(True)

    # ustawienia zakresu x tak, aby całe okno przesuwało się w przód (scroll)
    xmax = x[-1]
    xmin = xmax - szerokosc_okna
    # nie dopuść do przesunięcia za początek dostępnych danych
    xmin = max(xmin, x[0])
    # jeśli dostępny zakres jest mniejszy niż szerokosc_okna, wyświetl cały zakres
    if xmax - xmin < 1e-9:
        xmin = x[0]
    os.set_xlim(xmin, xmax)

    canvas.draw()

# Funkcje sterujące (pauza, przewijanie, zoom)
def pauza_wznowienie():
    global czy_pauza, czas_pauzy, czas_ostatniej_pauzy
    czy_pauza = not czy_pauza
    if czy_pauza:
        przycisk_pauza.config(text="Wznów")
        # start pomiaru pauzy
        czas_ostatniej_pauzy = time.time()
        # pozwól zresetować gdy zatrzymane/pauzowane
        przycisk_reset.config(state=tk.NORMAL)
    else:
        przycisk_pauza.config(text="Pauza")
        # dolicz czas pauzy
        if czas_ostatniej_pauzy is not None:
            czas_pauzy += time.time() - czas_ostatniej_pauzy
            czas_ostatniej_pauzy = None
        # reset zablokowany podczas pracy
        przycisk_reset.config(state=tk.DISABLED)
        
def zwolnij_prędkość():
    """Zmniejsz prędkość symulacji (x0.5), minimalnie x0.125"""
    global predkosc, speed_label
    predkosc = max(predkosc / 2.0, 0.125)
    speed_label.config(text=f"x{predkosc:.3g}")

def przyspiesz_prędkość():
    """Zwiększ prędkość symulacji (x2), maksymalnie x16"""
    global predkosc, speed_label
    predkosc = min(predkosc * 2.0, 16.0)
    speed_label.config(text=f"x{predkosc:.3g}")

def przewin_wstecz():
    x_min, x_max = os.get_xlim()
    szerokosc = x_max - x_min
    os.set_xlim(x_min - szerokosc * 0.1, x_max - szerokosc * 0.1)
    canvas.draw()

def przewin_do_przodu():
    x_min, x_max = os.get_xlim()
    szerokosc = x_max - x_min
    os.set_xlim(x_min + szerokosc * 0.1, x_max + szerokosc * 0.1)
    canvas.draw()

def zoom_in():
    """Zoom in on the x-axis."""
    x_min, x_max = os.get_xlim()
    range_width = x_max - x_min
    min_range_width = 0.1  # Set a smaller minimum range width to allow deeper zooming
    if range_width > min_range_width:  # Allow zooming in until the range width reaches the minimum
        os.set_xlim(x_min + range_width * 0.1, x_max - range_width * 0.1)
    canvas.draw()

def zoom_out():
    """Zoom out on the x-axis."""
    x_min, x_max = os.get_xlim()
    range_width = x_max - x_min
    os.set_xlim(x_min - range_width * 0.1, x_max + range_width * 0.1)
    canvas.draw()

# GUI
root = tk.Tk()
root.title("System akwizycji danych")
fig = Figure(figsize=(6, 4), dpi=100)
os = fig.add_subplot(111)
os.set_title("Brak danych, rozpocznij pomiar")
canvas = FigureCanvasTkAgg(fig, master=root)
canvas.get_tk_widget().pack(padx=10, pady=10)

# Przyciski - Pierwszy rząd (Start, Pauza, Przewijanie, Zoom)
ramka_przyciskow_1 = tk.Frame(root)
ramka_przyciskow_1.pack(pady=10)

przycisk_start = tk.Button(ramka_przyciskow_1, text="Start pomiaru", font=("Arial", 10), command=rozpocznij_pomiar)
przycisk_start.pack(side=tk.LEFT, padx=5)

przycisk_pauza = tk.Button(ramka_przyciskow_1, text="Pauza", font=("Arial", 10), command=pauza_wznowienie)
przycisk_pauza.pack(side=tk.LEFT, padx=5)

# Przyciski sterujące prędkością (obok przewijania)
przycisk_zwolnij = tk.Button(ramka_przyciskow_1, text="<<", font=("Arial", 10), command=zwolnij_prędkość)
przycisk_zwolnij.pack(side=tk.LEFT, padx=5)

przycisk_wstecz = tk.Button(ramka_przyciskow_1, text="<", font=("Arial", 10), command=przewin_wstecz)
przycisk_wstecz.pack(side=tk.LEFT, padx=5)

# etykieta pokazująca aktualną prędkość
speed_label = tk.Label(ramka_przyciskow_1, text=f"x{predkosc:.2f}", font=("Arial", 10))
speed_label.pack(side=tk.LEFT, padx=(0,5))

przycisk_przod = tk.Button(ramka_przyciskow_1, text=">", font=("Arial", 10), command=przewin_do_przodu)
przycisk_przod.pack(side=tk.LEFT, padx=5)

przycisk_przyspiesz = tk.Button(ramka_przyciskow_1, text=">>", font=("Arial", 10), command=przyspiesz_prędkość)
przycisk_przyspiesz.pack(side=tk.LEFT, padx=5)

przycisk_zoom_in = tk.Button(ramka_przyciskow_1, text="Zoom In", font=("Arial", 10), command=zoom_in)
przycisk_zoom_in.pack(side=tk.LEFT, padx=5)

przycisk_zoom_out = tk.Button(ramka_przyciskow_1, text="Zoom Out", font=("Arial", 10), command=zoom_out)
przycisk_zoom_out.pack(side=tk.LEFT, padx=5)

# Przyciski - Drugi rząd (Reset, Zakończ)
ramka_przyciskow_2 = tk.Frame(root)
ramka_przyciskow_2.pack(pady=10)

przycisk_reset = tk.Button(ramka_przyciskow_2, text="Resetuj pomiar", font=("Arial", 10), command=resetuj_pomiar)
przycisk_reset.pack(side=tk.LEFT, padx=5)

przycisk_zakoncz = tk.Button(ramka_przyciskow_2, text="Zakończ", font=("Arial", 10), command=root.destroy)
przycisk_zakoncz.pack(side=tk.LEFT, padx=5)

# Uruchomienie GUI
if __name__ == "__main__":
    root.mainloop()
