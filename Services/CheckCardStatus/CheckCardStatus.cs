using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace CheckCardStatus
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in both code and config file together.
    public class CheckCardStatus : ICheckCardStatus
    {
        public bool VerifyCard(string authtoken,string cardnumber, int cvvNumber,DateTime dateOfExpiry)
        {
            bool flag = false;
            var dbcheck = new SDProject();

            string returnValue= dbcheck.SP_CheckAuthenticateTranscation(authtoken, cardnumber, cvvNumber, dateOfExpiry).FirstOrDefault();
            if (returnValue=="Passed")
            {
                flag = true;
            }
            return flag;
        }

     
    }
}
