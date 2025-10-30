using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Reflection;
using System.Runtime.InteropServices;
using System.IO;
using Automation.BDaq;

namespace AI_InstantAI
{
   class InstantAI
   {
      static void Main(string[] args)
      {
         // Konfiguracja parametrów
         // string opisUrzadzenia = "USB-4702,BID#0
         string    opisUrzadzenia = "DemoDevice,BID#0";
         string    sciezkaProfilu = "../../../../../../../profile/DemoDevice.xml";
         int       kanalStartowy = 0;
         const int liczbaKanalow = 1;
         double    czestotliwoscProbkowania = 10.0; // Hz - częstotliwość próbkowania

         ErrorCode kodBledu = ErrorCode.Success;
         
         // Lista do przechowywania pomiarów
         List<string> pomiary = new List<string>();

         // Utworzenie kontrolera AI
         InstantAiCtrl kontrolerAI = new InstantAiCtrl();

         try
         {
            // Wybór urządzenia i ładowanie profilu
            kontrolerAI.SelectedDevice = new DeviceInformation(opisUrzadzenia);
            kodBledu = kontrolerAI.LoadProfile(sciezkaProfilu);
            if (BioFailed(kodBledu))
            {
               throw new Exception();
            }
            // Odczyt próbek
            int maksymalnaLiczbaKanalow = kontrolerAI.Features.ChannelCountMax;
            double[] daneSkalowane = new double[liczbaKanalow];
            
            // Inicjalizacja śledzenia czasu
            DateTime czasStartu = DateTime.Now;
            double znacznikCzasuSekundy = 0.0;
            
            do
            {
               // Odczyt próbek
               kodBledu = kontrolerAI.Read(kanalStartowy, liczbaKanalow, daneSkalowane);
               if (BioFailed(kodBledu))
               {
                  throw new Exception();
               }
               
               // Obliczanie znacznika czasu
               znacznikCzasuSekundy = (DateTime.Now - czasStartu).TotalSeconds;
               
               // Wyświetlanie danych w formacie: czas,wartość
               for (int i = 0; i < liczbaKanalow; ++i)
               {
                  string liniaDanych = string.Format("{0:f2},{1:f8}", znacznikCzasuSekundy, daneSkalowane[i]);
                  Console.Write(liniaDanych + "\n");
                  pomiary.Add(liniaDanych);
               }
               
               // Czas oczekiwania na podstawie częstotliwości
               int czasOczekiwaniaMs = (int)(1000.0 / czestotliwoscProbkowania);
               Thread.Sleep(czasOczekiwaniaMs);
            } while (!Console.KeyAvailable);
         }
         catch (Exception e)
         {
            // Obsługa błędów
            string komunikatBledu = BioFailed(kodBledu) ? " Wystąpił błąd. Kod błędu: " + kodBledu.ToString()
                                                 : e.Message;
            Console.WriteLine(komunikatBledu);
         }
         finally
         {
            // Zamknięcie urządzenia
            kontrolerAI.Dispose();
            
            // Zapis pomiarów do pliku CSV
            try
            {
               string nazwaPliku = "pomiary_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".csv";
               
               // Przejście 3 katalogi w górę
               string biezacyKatalog = Directory.GetCurrentDirectory();
               string katalogDocelowy = Path.GetDirectoryName(Path.GetDirectoryName(Path.GetDirectoryName(biezacyKatalog)));
               
               string pelnaSciezka = Path.Combine(katalogDocelowy, nazwaPliku);
               // Dodaj nagłówek CSV i dane
               var linieCsv = new List<string>();
               linieCsv.Add("Czas [s],Wartość [V]");
               linieCsv.AddRange(pomiary);
               File.WriteAllLines(pelnaSciezka, linieCsv);
               Console.WriteLine("\nDane zapisane do: " + pelnaSciezka);
               Console.WriteLine("Liczba pomiarów: " + pomiary.Count);
            }
            catch (Exception ex)

            {
               Console.WriteLine("\nBłąd zapisu pliku CSV: " + ex.Message);
               Console.WriteLine("Bieżący katalog: " + Directory.GetCurrentDirectory());
            }
            
            Console.ReadKey(false);
         }
      }

      static bool BioFailed(ErrorCode err)
      {
         return err < ErrorCode.Success && err >= ErrorCode.ErrorHandleNotValid;
      }
   }
}
