using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AvensiaWebShop.TestData
{
    public class TestPerson
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Gender { get; set; }
        public int Age { get; set; }
        public int Length { get; set; }

        public static List<TestPerson> GetPersons(int numberOfPeople)
        {
            string[] maleNames =
            {
                "Hiro", "Teiki", "Moana", "Manua", "Marama", "Teiva", "Teva", "Maui", "Tehei", "Tamatoa", "Ioane",
                "Tapuarii"
            };

            string[] femaleNames =
            {
                "Tiare", "Hinano", "Poema", "Maeva", "Hina", "Vaea", "Titaua", "Moea", "Moeata", "Tarita", "Titaina",
                "Teura", "Heikapu", "Mareva"
            };

            string[] lastNames =
            {
                "Díaz", "Mora", "Rodríguez", "González", "Hernández", "Morales", "Sánchez", "Ramírez", "Pérez",
                "Calderón", "Gutiérrez", "Rojas", "Salas", "Vargas", "Torres", "Segura", "Valverde", "Villalobos",
                "Araya", "Herrera", "López", "Madrigal"
            };

            Random random = new Random();

            List<TestPerson> persons = new List<TestPerson>();

            for (int i = 0; i < numberOfPeople; i++)
            {
                var firstName = "";
                var gender = "";
                if (i % 2 == random.Next(0, 2))
                {
                    firstName = maleNames[random.Next(0, maleNames.Length)];
                    gender = "Male";
                }
                else
                {
                    firstName = femaleNames[random.Next(0, femaleNames.Length)];
                    gender = "Female";
                }

                var lastName = lastNames[random.Next(0, lastNames.Length)];

                persons.Add(
                    new TestPerson()
                    {
                        FirstName = firstName,
                        LastName = lastName,
                        Age = random.Next(10, 105),
                        Gender = gender,
                        Length = random.Next(150, 195)
                    }
                    );
            }

            return persons;
        }

        public override string ToString()
        {
            return $"{FirstName} {LastName}, {Gender}, age {Age}, {Length} cm tal";
        }

    }
}