# Importowane biblioteki
import tkinter as tk # GUI
from tkinter import messagebox, ttk
import win32print # Drukowanie plików
# Tagi tekstu (pogrubienie itd.)
is_bold = False
is_italic = False
is_underline = False
orientation = "portrait" # Domyślne drukowanie na kartce pionowo
# Funkcje przełączania formatowania tekstu
def toggle_bold():
    global is_bold
    is_bold = not is_bold
    bold_btn.config(relief=tk.SUNKEN if is_bold else tk.RAISED)
def toggle_italic():
    global is_italic
    is_italic = not is_italic
    italic_btn.config(relief=tk.SUNKEN if is_italic else tk.RAISED)
def toggle_underline():
    global is_underline
    is_underline = not is_underline
    underline_btn.config(relief=tk.SUNKEN if is_underline else tk.RAISED)
# Funkcja do zmiany orientacji druku
def toggle_orientation():
    """Zmiana orientacji drukowania."""
    global orientation
    if orientation == "portrait":
        orientation = "landscape"
        orient_btn.config(text="Landscape", relief=tk.SUNKEN)
    else:
        orientation = "portrait"
        orient_btn.config(text="Portrait", relief=tk.RAISED)
# Funkcja wysyłająca plik do drukarki
def send_to_printer():
    # Carriage return (powrót kursora na początek wiersza)
    text = text_box.get("1.0", tk.END).rstrip()
    text = text.replace("\n", "\r\n")
    # Zapobieganie wydrukowania pustej kartki
    if not text:
        messagebox.showwarning("Uwaga", "Wprowadź tekst do druku")
        return
    # Zmienne ustawień czcionki
    family = font_family_var.get()
    size = font_size_var.get()
    # Ustawienie języka PCL
    pcl_header = "\x1B%-12345X@PJL ENTER LANGUAGE=PCL\r\n"
    # Escape code orientacji druku
    pcl_orientation = "\x1B&l0O" if orientation == "portrait" else "\x1B&l1O"
    # Lista czcionek (ograniczona do wybranych czcionek akceptowanych przez drukarkę)
    font_map = {
        "Courier": 0,
        "Letter Gothic": 3,
        "Times New Roman": 4101,
        "Arial": 16602
    }
    # Zmienne używane przez escape cody formatu
    typeface = font_map.get(family, 0)
    weight = 3 if is_bold else 0
    slant = 1 if is_italic else 0
    underline_on = "\x1B&d0D" if is_underline else ""
    underline_off = "\x1B&d@" if is_underline else ""
    # Wybór czcionki 
    # Czcionki ze stałą szerokością zapisywane są inaczej (Courier, Letter Gothic)
    if family in ["Courier", "Letter Gothic"]:
        pcl_font_select = f"\x1B(s0p10h0s{weight}b{typeface}T"
    else:
        pcl_font_select = f"\x1B(s1p{size}v{slant}s{weight}b{typeface}T"
    # Zapisanie wszystkich ustawień, formatowania oraz tekstu do zmiennej pcl_data
    pcl_data = (
        pcl_header +
        pcl_orientation +
        pcl_font_select +
        underline_on +
        text +
        underline_off +
        "\f" +  # Koniec strony
        "\x1B%-12345X"  # Reset PCL
    )
    # Próba wydruku
    try:
        printer_name = win32print.GetDefaultPrinter() # Nazwa drukarki (w tym przypadku domyślna drukarka ustawiona w systemie)
        hPrinter = win32print.OpenPrinter(printer_name)
        hJob = win32print.StartDocPrinter(hPrinter, 1, ("PCL Print Job", None, "RAW"))
        win32print.StartPagePrinter(hPrinter)
        win32print.WritePrinter(hPrinter, pcl_data.encode("utf-8"))
        win32print.EndPagePrinter(hPrinter)
        win32print.EndDocPrinter(hPrinter)
        win32print.ClosePrinter(hPrinter)
        messagebox.showinfo("Sukces", f"Wysłano do drukarki: {printer_name}")
    except Exception as e:
        messagebox.showerror("Błą", f"Błąd w wysłaniu pliku do druku:\n{e}")
# Interfejs graficzny
root = tk.Tk()#
root.title("Drukowanie wykorzystując język PCL")
root.geometry("650x550")
# Pole tekstowe
tk.Label(root, text="Wprowadź tekst:", font=("Arial", 12)).pack(pady=5)
text_box = tk.Text(root, wrap="word", height=15, width=70, font=("Courier New", 11))
text_box.pack(padx=10, pady=5, fill=tk.BOTH, expand=True)
# Pasek narzędzi
toolbar = tk.Frame(root)
toolbar.pack(pady=5)
# Przyciski formatowania
bold_btn = tk.Button(toolbar, text="Pogrubienie", command=toggle_bold, width=10)
italic_btn = tk.Button(toolbar, text="Kursywa", command=toggle_italic, width=10)
underline_btn = tk.Button(toolbar, text="Podkreślenie", command=toggle_underline, width=10)
orient_btn = tk.Button(toolbar, text="Portrait", command=toggle_orientation, width=10, bg="lightgray")
# Ustawienie przycisków
bold_btn.grid(row=0, column=0, padx=5)
italic_btn.grid(row=0, column=1, padx=5)
underline_btn.grid(row=0, column=2, padx=5)
orient_btn.grid(row=0, column=3, padx=5)
# Ustawienie czcionki
font_frame = tk.Frame(root)
font_frame.pack(pady=5)
# Krój czcionki
tk.Label(font_frame, text="Krój Czcionki:", font=("Arial", 10)).grid(row=0, column=0, padx=5)
font_family_var = tk.StringVar(value="Courier")
font_family_cb = ttk.Combobox(
    font_frame, textvariable=font_family_var,
    values=["Courier", "Letter Gothic", "Times New Roman", "Arial"],
    state="readonly", width=20
)
font_family_cb.grid(row=0, column=1, padx=5)
# Rozmiar
tk.Label(font_frame, text="Rozmiar Czcionki:", font=("Arial", 10)).grid(row=0, column=2, padx=5)
font_size_var = tk.StringVar(value="12")
font_size_cb = ttk.Combobox(
    font_frame, textvariable=font_size_var,
    values=["8", "10", "12", "14", "18", "24"],
    state="readonly", width=5
)
font_size_cb.grid(row=0, column=3, padx=5)
# Przycisk druku
send_button = tk.Button(
    root, text="Wyślij do druku",
    command=send_to_printer,
    bg="lightblue", font=("Arial", 12)
)
send_button.pack(pady=15)
# Akrywacja programu
root.mainloop()
