using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQ_Comman.Helpers
{
    public static class ConfigHelper
    {
        public static string GetAppSetting(string name)
        {
            return GetAppSetting(name, string.Empty);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="name"></param>
        /// <param name="defaultValue"></param>
        /// <returns></returns>
        public static string GetAppSetting(string name, string defaultValue)
        {
            string str = ConfigurationManager.AppSettings[name];
            if (str != null)
            {
                return str;
            }
            return defaultValue;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="keyName"></param>
        /// <param name="defaultValue"></param>
        /// <returns></returns>
        public static bool GetBool(string keyName, bool defaultValue)
        {
            return ToBool(GetAppSetting(keyName, ""), defaultValue);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="keyName"></param>
        /// <returns></returns>
        public static int GetIntValue(string keyName)
        {
            return GetIntValue(keyName, 0, true, int.MaxValue);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="keyName"></param>
        /// <param name="defaultValue"></param>
        /// <returns></returns>
        public static int GetIntValue(string keyName, int defaultValue)
        {
            return GetIntValue(keyName, defaultValue, true, int.MaxValue);
        }

        /// <summary>
        /// return a value from a collection of a default value if not in that collection
        /// </summary>
        /// <param name="keyName">key name from config collecion</param>
        /// <param name="defaultValue">a default value</param>
        /// <param name="zeroAllowed">is zero allowed</param>
        /// <param name="maxValueAllowed">what is the largest number that will be accepted</param>
        /// <returns>a value</returns>
        public static int GetIntValue(string keyName, int defaultValue, bool zeroAllowed, int maxValueAllowed)
        {
            int result;
            string valueToParse = ConfigurationManager.AppSettings[keyName];
            if (valueToParse == null)
            {
                return defaultValue;
            }
            if (!int.TryParse(valueToParse, out result))
            {
                if (zeroAllowed)
                {
                    throw new Exception("Value must be non negative integer");
                }
                throw new Exception("Value must be positive integer");
            }
            if (zeroAllowed && (result < 0))
            {
                throw new Exception("Value must be non negative integer");
            }
            if (!zeroAllowed && (result <= 0))
            {
                throw new Exception("Value must be positive integer");
            }
            if ((maxValueAllowed > 0) && (result > maxValueAllowed))
            {
                throw new Exception("Value too big");
            }
            return result;
        }

        private static bool ToBool(string value, bool defaultValue)
        {
            if (string.IsNullOrEmpty(value))
            {
                return defaultValue;
            }
            if (!value.Equals("true", StringComparison.OrdinalIgnoreCase) && !value.Equals("yes", StringComparison.OrdinalIgnoreCase))
            {
                return value.Equals("1", StringComparison.OrdinalIgnoreCase);
            }

            return true;
        }
    }
}
