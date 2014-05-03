﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace LoginCheckService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in both code and config file together.

  
    public class LoginService : ILoginService
    {
        public string  GetLoginToken(string username,string password)
        {
            string token = null ;
            var ett = new MyTestingDatabase();
            var rtype = ett.AuthenticateUser(username, password);
            token=rtype.FirstOrDefault();    
            return token;
        }

    }
}
