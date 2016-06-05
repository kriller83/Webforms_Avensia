using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AvensiaWebShop.Models;

namespace AvensiaWebShop
{
    public partial class KampanjerTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BannerOneAnnons(1);
            BannerTwoAnnons(2);
            GetCampaigns(5);

        }

        protected void BannerOneAnnons(int kampanjId)
        {
            using (var db = new AvensiaWebshopEntities())
            {
                //Random random = new Random();
                //var selectedCampID = random.Next(1, 5);
                var selectedCamp = db.Kampanj.FirstOrDefault(k => k.KampanjID == kampanjId);
                Campaign_1.ImageUrl = "~/Images/Annonser/" + selectedCamp.KampanjImageName;
                Campaign_1.NavigateUrl = selectedCamp.KampanjURL;
            }
        }
        protected void BannerTwoAnnons(int kampanjId)
        {
            using (var db = new AvensiaWebshopEntities())
            {
                //Random random = new Random();
                //var selectedCampID = random.Next(1, 5);
                var selectedCamp = db.Kampanj.FirstOrDefault(k => k.KampanjID == kampanjId);
                Campaign_2.ImageUrl = "~/Images/Annonser/" + selectedCamp.KampanjImageName;
                Campaign_2.NavigateUrl = selectedCamp.KampanjURL;
            }
        }

        protected void GetCampaigns(int numberOfCampaigns)
        {
            var campaignsList = new List<Kampanj>();
            using (var db = new AvensiaWebshopEntities())
            {
                campaignsList = db.Kampanj.Where(c => c.KampanjStatus == "active").ToList();
                if (campaignsList.Count > numberOfCampaigns)
                {
                    int numberToRemove = campaignsList.Count - numberOfCampaigns;
                    campaignsList.RemoveRange(numberOfCampaigns, numberToRemove);
                }
                
            }
            repCampaign.DataSource = campaignsList;
            repCampaign.DataBind();
        }

        //internal void GetCampaigns(int numberOfCampaigns)
        //{
        //    var campaignsList = new List<Kampanj>();
        //    //var currentDate = DateTime.Now;
            

        //    using (var db = new AvensiaWebshopEntities())
        //    {
        //        campaignsList =
        //                          db.Kampanj.Where(
        //                              c =>
        //                                  c.KampanjStart != null && c.KampanjEnd != null).ToList();


        //        if (campaignsList.Count > numberOfCampaigns)
        //        {
        //            campaignsList.RemoveRange(numberOfCampaigns, campaignsList.Count - 1);
        //        }
        //        else if (campaignsList.Count < numberOfCampaigns)
        //        {
        //            int numberOfMissingCampaings = numberOfCampaigns - campaignsList.Count;
        //            var defaultCampaingsList = new List<Kampanj>();
        //            defaultCampaingsList = db.Kampanj.Where(d => d.KampanjStatus == "default").Take(numberOfMissingCampaings).ToList();
        //            for (int i = 0; i < defaultCampaingsList.Count; i++)
        //            {
        //                campaignsList.Add(defaultCampaingsList[i]);
        //            }
        //        }
        //    }
        //    //return campaignsList;
        //    repCampaign.DataSource = campaignsList;
        //    repCampaign.DataBind();
        //}

        //internal void LoadCampaignsOnTestPage()
        //{
        //    repCampaign.DataSource = GetCampaigns(5);
        //    repCampaign.DataBind();
        //}
    }
}
