using System;
using System.Linq;
namespace lab_4ISIT
{
    class Program
        {
        static void Main(string[] args)
        {
            Console.WriteLine("1. Метод относительного большинства");
            Console.WriteLine("2. Модель Кондорсе: явный победитель");
            Console.WriteLine("3. Модель Борда");
            Console.Write("Выберите метод для принятия коллективного решения (введите номер): ");
            int number = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Участники:");
            Console.WriteLine("1. Работа Участника 1");
            Console.WriteLine("2. Работа Участника 2");
            Console.WriteLine("3. Работа Участника 3");
            Console.WriteLine("4. Работа Участника 4");

            int m = 4;
            Console.Write("Введите кол-во избирателей: ");
            int n  = Convert.ToInt32(Console.ReadLine());
            if (number == 1)
                Otn_Bolsenstvo(n, m);
            if (number == 2)
                M_Konderse(n, m);
            if (number == 3)
                M_bord(n, m);


            Console.ReadKey();
        }
        static void Otn_Bolsenstvo(int n, int m)
        {
            int[,] mas = new int[n, m];
            mas = Vvod(n, m);
            int[] Poss_sum = Sum(mas, m, n);
            int[] newPoss = Poisk_znach(Poss_sum, m, n, 1);
            int[] newPoss_sum = Poisk_znach(Poss_sum, m, n, 2);
            Result(newPoss, newPoss_sum, m);
        }

        static void Result(int[] mas, int[] mas_2, int m)
        {
            for (int l = 0; l < m; l++)
                Console.WriteLine($" Кондидат: {mas[l] + 1} (Результат: {mas_2[l]}) >");
            Console.WriteLine();
            Console.WriteLine($" Победил кондидат с порядковым номером: {mas[0] + 1}");
        }
        static int[] Poisk_znach(int[] Pas, int m, int n, int op)
        {
            int[] P = new int[Pas.Length];
            Pas.CopyTo(P, 0);
            int[] newPoss = new int[m];
            int[] newPoss_sum = new int[m];
            for (int l = 0; l < m; l++)
                Console.Write($" {Pas[l]}");
            Console.WriteLine();
            for (int j = 0; j < m; j++)
            {
                int ch = 0;
                int max = P.Min();
                for (int l = 0; l < m; l++)
                {
                    if (max < P[l])
                    {
                        max = P[l];
                        ch = l;
                    }
                }

                P[ch] = -1;
                newPoss[j] = ch;
                newPoss_sum[j] = max;
            }
            if (op == 1)
                return newPoss;
            else
                return newPoss_sum;
        }
        static int[,] Vvod(int n, int m)
        {
            int[,] mas = new int[n, m];
            Console.WriteLine($"Проранжируйте участников от меньшего к большему , присваивая значения от 0 до {m - 1}:");
            for (int i = 0; i < n; i++)
            {
                Console.WriteLine($"Оценщик № {i + 1} : ");
                for (int j = 0; j < m; j++)
                {
                    Console.Write($"Участник № {j + 1} : ");
                    mas[i, j] = Convert.ToInt32(Console.ReadLine());
                }
                Console.WriteLine();
            }
            return mas;
        }
        static int[] Sum(int[,] mas, int m, int n)
        {
            int[] Poss_sum = new int[m];
            for (int j = 0; j < m; j++)
            {
                int sum = 0;
                for (int l = 0; l < n; l++)
                {
                    if (mas[l, m - 1] == j)
                        sum++;
                }
                Poss_sum[j] = sum;
            }
            return Poss_sum;
        }

        static void M_Konderse(int n, int m)
        {
            int[,] mas = new int[n, m];
            mas = Vvod(n, m);
            int[] Poss = new int[(m * (m - 1)) / 2];
            int t1 = 0;
            int t2 = 1;
            int s1 = 0;
            int s2 = 0;
            for (int i = 0; i < (m * (m - 1)) / 2; i++)
            {
                for (int k = 0; k < n; k++)
                {
                    for (int j = 0; j < m; j++)
                    {
                        if (mas[k, j] == t1)
                            s1 = j;
                        if (mas[k, j] == t2)
                            s2 = j;
                    }
                    if (s1 > s2)
                        Poss[i] = t1;
                    else
                        Poss[i] = t2;
                }
                if (t2 < m - 1)
                    t2++;
                else
                {
                    t1++;
                    t2 = t1 + 1;
                }
            }
            int[] Poss_sum = new int[m];
            for (int j = 0; j < m; j++)
            {
                int sum = 0;
                for (int l = 0; l < (m * (m - 1)) / 2; l++)
                {
                    if (Poss[l] == j)
                        sum++;
                }
                Poss_sum[j] = sum;
            }
            int[] newPoss = Poisk_znach(Poss_sum, m, n, 1);
            int[] newPoss_sum = Poisk_znach(Poss_sum, m, n, 2);

            Result(newPoss, newPoss_sum, m);

            //
        }



        static void M_bord(int n, int m)
        {
            int[,] mas = new int[n, m];
            mas = Vvod(n, m);
            int[] Summ = new int[m];
            for (int i = 0; i < n; i++)
                for (int j = 0; j < m; j++)
                    for (int k = 0; k < m; k++)
                        if (mas[i, j] == k)
                            Summ[k] = Summ[k] + j;

            for (int k = 0; k < m; k++)
                if (Summ[k] == Summ.Max())
                    Console.WriteLine($"В соответствии с этим методом победил кондидат под номером {k}, получивший результат: { Summ.Max()}");

        }


    }
}
