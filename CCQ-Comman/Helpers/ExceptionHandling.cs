using Microsoft.SharePoint;

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;

using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;


namespace CCQ_Comman.Helpers
{
    public class ExceptionHandling
    {
        public static void ProcessDataException(Exception ex)
        {
            try
            {
            
               
              string  eLog = "CCQPortalError";

                string errorMessage = ex.Message + "\r\n" + ex.StackTrace;
                var st = new StackTrace(ex, true);
                var frame = st.GetFrame(0);
                var line = frame.GetFileLineNumber();
                var currentMethodName = st.GetFrame(0).GetMethod();

                errorMessage += "=======================================\n";
                errorMessage += st.ToString() + "\n";
                errorMessage += frame.ToString() + "\n";
                errorMessage += line.ToString() + "\n";
                errorMessage += "Method Giving Error" + currentMethodName + "\n";


                SPSecurity.RunWithElevatedPrivileges(delegate ()
                {
                    using (EventLog eventLog = new EventLog("CCQPortalError"))
                    {
                        eventLog.Source = "CCQPortalError";
                        eventLog.WriteEntry(errorMessage, EventLogEntryType.Error, 101, 1);
                    }

                });
            }
            catch (Exception e)
            {

            }
        }
    }
}