using MySql.Data.MySqlClient;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace rockZenekarokGUI
{
	/// <summary>
	/// Interaction logic for MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window
	{
		public MainWindow()
		{
			InitializeComponent();
		}

		private async void btn_betoltes(object sender, RoutedEventArgs e)
		{
			try
			{
				string connectionString = "Server=127.0.0.1;Port=3307;Database=rock_zenekarok_70s;Uid=root;Pwd=;";
				using (MySqlConnection connection = new MySqlConnection(connectionString))
				{
					connection.Open();

					string query = "SELECT nev,tagok,kep_url,aktiv_evek FROM zenekarok";
					MySqlCommand command = new MySqlCommand(query, connection);

					using (MySqlDataReader reader = command.ExecuteReader())
					{
						List<Zenekar> bands = new List<Zenekar>();
						while (reader.Read())
						{
							Zenekar band = new Zenekar
							{
								Nev = reader.GetString("nev"),
								Tagok = reader.GetString("tagok"),
								KepUrl = reader.GetString("kep_url"),
								AktivIdoszak = reader.GetString("aktiv_evek")
							};
							bands.Add(band);
						}

						zenekarokLista.ItemsSource = bands;
						btn_betolt.IsEnabled = false;
					}
				}
			}
			catch
			{
				MessageBox.Show("Nem sikerült csatlakozni az adatbázishoz vagy lekérni az adatokat.");
			}
		}

		private void zenekarokLista_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			if (zenekarokLista.SelectedItem != null)
			{
				var selectedBand = (Zenekar)zenekarokLista.SelectedItem;

				zenekarKep.Source = new BitmapImage(new Uri(selectedBand.KepUrl, UriKind.RelativeOrAbsolute));

				string aktivIdoszak = selectedBand.AktivIdoszak;
				int aktivEvek = 0;

				if (aktivIdoszak.Contains("napjainkig"))
				{
					int kezdetEv = int.Parse(aktivIdoszak.Split('–')[0].Trim());
					aktivEvek = DateTime.Now.Year - kezdetEv;
				}
				else
				{
					string[] idoszak = aktivIdoszak.Split('–');
					int kezdetEv = int.Parse(idoszak[0].Trim());
					int vegEv = int.Parse(idoszak[1].Trim());
					aktivEvek = vegEv - kezdetEv;
				}

				txt_aktiv.Text = $"{aktivEvek}";
			}
		}
	}
}