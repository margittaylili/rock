using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace Rockzenekar
{
	internal class Program
	{
		static void Main(string[] args)
		{
			string zenekarok_file = "rockZenekarok.csv";
			string stilusok_file = "rockStilusok.csv";

			List<Zenekar> zenekarok;
			List<Stilus> stilusok;
			try
			{
				zenekarok = Beolvas(zenekarok_file);
				stilusok = BeolvasStilusok(stilusok_file);
			}
			finally
			{
				Console.WriteLine("5. feladat: A beolvasás sikeresen megtörtént.");
			}

			//6. feladat
			var zenekarok1968Utan = zenekarok.Where(z =>
			{
				if (int.TryParse(z.AktivEvek.Split('–')[0], out int alakulasiEv))
				{
					return alakulasiEv > 1968;
				}
				return false;
			}).ToList();
			Console.WriteLine($"6. feladat: {zenekarok1968Utan.Count} zenekar alakult 1968 után:");
			foreach (var zenekar in zenekarok1968Utan)
			{
				Console.Write($"{zenekar.Nev}	");
			}
			Console.WriteLine();
			Console.WriteLine();

			//8. feladat
			Console.Write("8. feladat: Adja meg, melyik zenei stílusra kíváncsi: ");
			string kivancs = Console.ReadLine();
			int stilusId = Azonosito(kivancs, stilusok);
			var talalatok = zenekarok.Where(z => int.Parse(z.StilusId) == stilusId).ToList();

			if (talalatok.Count > 0)
			{
				Console.Write($"A {kivancs} stílushoz tartozó zenekarok:	");
				foreach (var zenekar in talalatok)
				{
					Console.Write($"{zenekar.Nev}	");
				}
			}
			else
			{
				Console.WriteLine($"Nincs ilyen zenekar az adatbázisban.");
			}

			Console.WriteLine();
			Console.WriteLine();
			Console.WriteLine("A befejezéshez nyomjon ENTER-t ");
			Console.ReadKey();

		}
		static List<Zenekar> Beolvas(string filePath)
		{
			var zenekarok = new List<Zenekar>();

			if (!File.Exists(filePath))
			{
				Console.WriteLine("A fájl nem található: " + filePath);
				return zenekarok;
			}

			var lines = File.ReadAllLines(filePath);

			for (int i = 1; i < lines.Length; i++)
			{
				var line = lines[i];
				var parts = line.Split(';');

				var zenekar = new Zenekar
				{
					Id = parts[0],
					Nev = parts[1],
					StilusId = parts[2],
					Orszag = parts[3],
					Varos = parts[4],
					AktivEvek = parts[5],
					Tagok = parts[6],
					LegsikeresebbAlbum = parts[7],
					KepUrl = parts[8],
				};

				zenekarok.Add(zenekar);
			}

			return zenekarok;
		}
		static List<Stilus> BeolvasStilusok(string filePath)
		{
			var stilusok = new List<Stilus>();

			if (!File.Exists(filePath))
			{
				Console.WriteLine("A fájl nem található: " + filePath);
				return stilusok;
			}

			var lines = File.ReadAllLines(filePath);

			for (int i = 1; i < lines.Length; i++) 
			{
				var line = lines[i];
				var parts = line.Split(';');

				var stilus = new Stilus
				{
					Id = int.Parse(parts[0]),
					Nev = parts[1]          
				};

				stilusok.Add(stilus);
			}

			return stilusok;
		}

		static int Azonosito(string stilusNev, List<Stilus> stilusok)
		{
			var stilus = stilusok.FirstOrDefault(s => s.Nev.Equals(stilusNev, StringComparison.OrdinalIgnoreCase));
			if (stilus != null)
			{
				return stilus.Id;
			}
			else
			{
				throw new ArgumentException("A megadott stílus nem található.");
			}
		}
	}
}
