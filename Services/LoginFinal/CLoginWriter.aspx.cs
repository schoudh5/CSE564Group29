using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CLoginWriter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uname"] != null && Request.QueryString["pass"]!=null)
        {
            DReferLogin.LoginServiceClient lsc = new DReferLogin.LoginServiceClient();
            var reply = lsc.GetLoginToken(Request.QueryString["uname"], Request.QueryString["pass"]);
            Response.Write(reply);
        }
        else
        {
            Response.Write("Invalid parameters");
        }
    }
}