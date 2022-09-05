using Microsoft.SharePoint;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQ_Etqan.EtqanComman
{
    public class ExceptionHandling
    {
        public static void ProcessDataException(Exception ex)
        {
            try
            {


                string eLog = "CCQEtqanError";

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
                        eventLog.Source = "CCQEtqanError";
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
