using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Diagnostics;
using System.IO;

namespace Shadiev_L12
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        #region Task3
        List<BitmapImage> Images = new List<BitmapImage>();
        int currentImage = 0;
        #endregion
        public MainWindow()
        {
            InitializeComponent();
            #region Task3
            Images.Add(new BitmapImage(new Uri(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Bear1.png"))));
            Images.Add(new BitmapImage(new Uri(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Bear2.png"))));
            Images.Add(new BitmapImage(new Uri(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Bear3.png"))));
            Images.Add(new BitmapImage(new Uri(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Bear4.png"))));
            Images.Add(new BitmapImage(new Uri(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Bear5.png"))));
            Images.Add(new BitmapImage(new Uri(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Bear6.png"))));
            Images.Add(new BitmapImage(new Uri(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Bear7.png"))));
            Images.Add(new BitmapImage(new Uri(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Bear8.png"))));
            Images.Add(new BitmapImage(new Uri(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Bear9.png"))));
            Images.Add(new BitmapImage(new Uri(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Bear10.png"))));
            Photo.Source = Images[currentImage];
            #endregion
        }
        #region Task3
        private void NextPhoto_Click(object sender, RoutedEventArgs e)
        {
            if (currentImage < Images.Count - 1) currentImage++;
            if (currentImage == 1) LastPhoto.Visibility = Visibility.Visible;
            if (currentImage == Images.Count - 1) NextPhoto.Visibility = Visibility.Collapsed;
            Photo.Source = Images[currentImage];
        }
        private void LastPhoto_Click(object sender, RoutedEventArgs e)
        {
            if (currentImage > 0) currentImage--;
            if (currentImage == 0) LastPhoto.Visibility = Visibility.Collapsed;
            if (currentImage == Images.Count - 2) NextPhoto.Visibility = Visibility.Visible;
            Photo.Source = Images[currentImage];
        }
        #endregion
        #region Task4
        private void StackPanel_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.OriginalSource is Image image)
                CurrentImage.Source = image.Source;
        }
        #endregion
    }
}
