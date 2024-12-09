using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows.Threading;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Timers;

namespace Shadiev_L11
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        DateTime? DT; //Task3
        public MainWindow()
        {
            InitializeComponent();
            Calendar2.BlackoutDates.Clear();
        }
        #region Task1
        private void Calendar1_SelectedDatesChanged(object sender, SelectionChangedEventArgs e) => MessageBox.Show(Calendar1.SelectedDate.Value.Date.ToShortDateString());
        #endregion
        #region Task3
        private void Calendar2_SelectedDatesChanged(object sender, SelectionChangedEventArgs e) => DT = Calendar2.SelectedDate;
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                TimeSpan time = (TimeSpan)(DT - DateTime.Now);
                MessageBox.Show($"{time.Days}/{time.Hours}:{time.Minutes}:{time.Seconds}");
            }
            catch
            {
                MessageBox.Show("Ну это\nНу типо\nТи вибрал этот же день");
            }
        }
        #endregion
    }
}
