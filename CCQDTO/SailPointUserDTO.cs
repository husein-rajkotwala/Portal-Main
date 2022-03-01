using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQDTO
{
  
        public class PasswordRefreshTask
        {
        }

        public class Administrator
        {
        }

        public class Account
        {
            public string displayName { get; set; }
            public string value { get; set; }

            [JsonProperty("$ref")]
            public string Ref { get; set; }
        }

        public class UrnIetfParamsScimSchemasSailpoint10User
        {
            public string workfax { get; set; }
            public string alternateemail { get; set; }
            public List<string> homecountry { get; set; }
            public string prefix { get; set; }
            public string ObjectGUID { get; set; }
            public string suffix { get; set; }
            public string passport { get; set; }
            public List<string> studentprogram { get; set; }
            public string mobilephone { get; set; }
            public string workzip { get; set; }
            public bool isManager { get; set; }
            public string dateofjoin { get; set; }
            public string dateofbirth { get; set; }
            public List<string> campus { get; set; }
            public string pdim { get; set; }
            public string homestreetline2 { get; set; }
            public List<string> workcountry { get; set; }
            public string homestreetline3 { get; set; }
            public List<string> nationality { get; set; }
            public string subdepartment { get; set; }
            public List<string> companyname { get; set; }
            public string homestreetline1 { get; set; }
            public List<string> workstate { get; set; }
            public List<string> martialstatus { get; set; }
            public List<string> studentlevel { get; set; }
            public PasswordRefreshTask PasswordRefreshTask { get; set; }
            public List<object> authenticationmethod { get; set; }
            public string emergencycontactname { get; set; }
            public string status { get; set; }
            public string emergencycontactemail { get; set; }
            public List<string> religious { get; set; }
            public string homezip { get; set; }
            public List<string> role { get; set; }
            public string homephone { get; set; }
            public string homecity { get; set; }
            public string qatarid { get; set; }
            public string legalname { get; set; }
            public string workphonenumber { get; set; }
            public List<string> stafftitle { get; set; }
            public string drivinglicense { get; set; }
            public List<string> homestate { get; set; }
            public string udcid { get; set; }
            public Administrator administrator { get; set; }
            public string dateofleave { get; set; }
            public List<object> term { get; set; }
            public List<string> genderstatus { get; set; }
            public string department { get; set; }
            public string currentapplications { get; set; }
            public string subdepartment1 { get; set; }
            public string emergencycontactnumber { get; set; }
            public List<object> capabilities { get; set; }
            public string guardianname { get; set; }
            public DateTime lastRefresh { get; set; }
            public string emergencycontactrealtionship { get; set; }
            public List<string> workcity { get; set; }
            public string workstreetline1 { get; set; }
            public string middlename { get; set; }
            public string workphonextn { get; set; }
            public string workstreetline2 { get; set; }
            public string workstreetline3 { get; set; }
            public string samaccountname { get; set; }
            public List<string> medicaldisability { get; set; }
            public List<string> reasonofleave { get; set; }
            public string workemail { get; set; }
            public List<Account> accounts { get; set; }
            public List<string> category { get; set; }
            public List<string> stafftype { get; set; }
            public string applications { get; set; }
            public string username { get; set; }
        }

        public class Email
        {
            public string type { get; set; }
            public string value { get; set; }
            public bool primary { get; set; }
        }

        public class Meta
        {
            public DateTime created { get; set; }
            public string location { get; set; }
            public DateTime lastModified { get; set; }
            public string version { get; set; }
            public string resourceType { get; set; }
        }

        public class Name
        {
            public string formatted { get; set; }
            public string familyName { get; set; }
            public string givenName { get; set; }
        }

        public class Manager
        {
        }

        public class UrnIetfParamsScimSchemasExtensionEnterprise20User
        {
            public Manager manager { get; set; }
        }

        public class Resource
        {
            [JsonProperty("urn:ietf:params:scim:schemas:sailpoint:1.0:User")]
            public UrnIetfParamsScimSchemasSailpoint10User UrnIetfParamsScimSchemasSailpoint10User { get; set; }
            public List<Email> emails { get; set; }
            public string displayName { get; set; }
            public Meta meta { get; set; }
            public List<string> schemas { get; set; }
            public Name name { get; set; }
            public bool active { get; set; }
            public string id { get; set; }
            public string userName { get; set; }

            [JsonProperty("urn:ietf:params:scim:schemas:extension:enterprise:2.0:User")]
            public UrnIetfParamsScimSchemasExtensionEnterprise20User UrnIetfParamsScimSchemasExtensionEnterprise20User { get; set; }
        }

        public class UserProperties
        {
            public int totalResults { get; set; }
            public int startIndex { get; set; }
            public List<string> schemas { get; set; }
            public List<Resource> Resources { get; set; }
        }
    }

