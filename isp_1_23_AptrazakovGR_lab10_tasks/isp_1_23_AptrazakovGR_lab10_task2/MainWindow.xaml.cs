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
using System.Windows.Shapes;



namespace isp_1_23_AptrazakovGR_lab10_task2
{
    public class Learn
    {
        public string Caption { get; set; }
        public string Teacher { get; set; }
        public int Auditor { get; set; }
    }
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            List<Learn> LearnList = new List<Learn>
            {
                new Learn {Caption="Теория вероятностей и математическая статистика", Teacher="Шаркова", Auditor=42},
                new Learn {Caption="Элементы высшей математики", Teacher="Олеся Климовна", Auditor=24},
                new Learn {Caption="Основы алгоритмизации и программирования", Teacher="Артём Андреевич", Auditor=8},
                new Learn {Caption="Разработка программных модулей", Teacher="Андрей Владиславович", Auditor=7},
            };
            myGrid.ItemsSource = LearnList;
        }
    }
}
