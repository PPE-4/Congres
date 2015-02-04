using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project_congres
{
    public class GestionDB
    {
        private static BdCongresEntities BD = new BdCongresEntities();

        public static BdCongresEntities getContexte()
        //permet de retourner le contexte de la DLL afin que toute l'application utilise la même référence à la base de données
        {
            return BD;
        }
        #region Theme

        public static List<THEME> GetAllThemes()
        {

            var req = from unTheme in BD.THEMES
                      select unTheme;
            List<THEME> lesThemes = req.ToList();
            return lesThemes;
        }
        public static void AddMedecin(Medecin unMedecin)
        {
            BD.Medecins.Add(unMedecin);
            BD.SaveChanges();

        }
        public static void RemoveMedecin(Medecin unMedecin)
        {

            BD.Medecins.Remove(unMedecin);
            BD.SaveChanges();
        }
        public static List<Dossier> GetDossierByMed(Medecin unMedecin)
        {
            var req = from unMed in BD.Dossiers
                      where unMed.idMedecin == unMedecin.idMed
                      select unMed;
            List<Dossier> lesDossierDeMed = req.ToList();
            return lesDossierDeMed;
        }
        public static void UpdateMedecin(Medecin Med, string nom, string prenom, string rue, string Cp, string Ville)
        {
            Med.nomMed = nom;
            Med.prenomMed = prenom;
            Med.adresseMed = rue;
            Med.cpMed = Cp;
            Med.villeMed = Ville;
            BD.SaveChanges();
        }
        #endregion

    }
}
