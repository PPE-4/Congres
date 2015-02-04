using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Project_congres;

namespace Test_Congres
{
    class Program
    {
        static void Main(string[] args)
        {

            BdCongresEntities bd = new BdCongresEntities();
            var req = from lecongr in bd.CONGRESSISTEs
                      select lecongr;
            CONGRESSISTE uncongr = req.FirstOrDefault();

            Console.WriteLine(uncongr.NOM);
            Console.ReadKey();
        }
    }
}
