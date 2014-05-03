using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CardVerfiication : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["token"]!=null && Request.QueryString["cardno"]!=null && Request.QueryString["cvvno"]!=null && Request.QueryString["doe"]!=null)
        {
            CheckCardDetails.CheckCardStatusClient ccsc = new CheckCardDetails.CheckCardStatusClient();

            int cvv=Convert.ToInt32(Request.QueryString["cvvno"]);
            var ddtime = Convert.ToDateTime(Request.QueryString["doe"]);
            if(ccsc.VerifyCard(Request.QueryString["token"], Request.QueryString["cardno"], cvv, ddtime))
            {
                Response.Write("Success");
            }
            else
            {
                Response.Write("Failed");
            }
        }
        else
        {
            Response.Write("Invalid Parameter");
        }
    }
}