using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using AvensiaWebShop.Models;

namespace AvensiaWebShop
{
    /// <summary>
    /// Summary description for Media
    /// </summary>
    public class Media : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            foreach (var query in context.Request.QueryString.AllKeys)
            {
                switch (query)
                {
                    case "image":
                        ReturnImage(context, context.Request.QueryString["image"].ToString());
                        break;
                    case "thumbnail":
                        ReturnTumbNail(context, context.Request.QueryString["thumbnail"].ToString());
                        break;
                    default:
                        Return404(context);
                        break;
                }
            }
        }

        private static void ReturnImage(HttpContext context, string imageNameQuery)
        {
            if (!string.IsNullOrWhiteSpace(imageNameQuery))
            {
                using (var db = new AvensiaWebshopEntities())
                {
                    var imageQuery = db.ProductPhoto.FirstOrDefault(i => i.LargePhotoFileName == imageNameQuery);

                    if (imageQuery == null)
                    {
                        Return404(context);
                        return;
                    }

                    context.Response.ContentType = "image/gif";
                    Stream strm = new MemoryStream(imageQuery.LargePhoto);
                    byte[] buffer = new byte[4096];
                    int byteSeq = strm.Read(buffer, 0, 4096);

                    while (byteSeq > 0)
                    {
                        context.Response.OutputStream.Write(buffer, 0, byteSeq);
                        byteSeq = strm.Read(buffer, 0, 4096);
                    }
                }
            }
        }

        private static void ReturnTumbNail(HttpContext context, string thumbNailProductIDQuery)
        {
            int productID;

            if (!string.IsNullOrWhiteSpace(thumbNailProductIDQuery) && int.TryParse(thumbNailProductIDQuery, out productID))
            {
                using (var db = new AvensiaWebshopEntities())
                {
                    var imageQuery = db.Product.FirstOrDefault(p => p.ProductID == productID);

                    if (imageQuery == null)
                    {
                        Return404(context);
                        return;
                    }

                    context.Response.ContentType = "image/gif";
                    Stream strm = new MemoryStream(imageQuery.ThumbNailPhoto);
                    byte[] buffer = new byte[4096];
                    int byteSeq = strm.Read(buffer, 0, 4096);

                    while (byteSeq > 0)
                    {
                        context.Response.OutputStream.Write(buffer, 0, byteSeq);
                        byteSeq = strm.Read(buffer, 0, 4096);
                    }
                }
            }
        }

        private static void Return404(HttpContext context)
        {
            context.Response.StatusCode = 404;
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}