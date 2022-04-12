using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQ_Comman.Constants
{
    public class CamlQueryException : ApplicationException
    {
        public CamlQueryException(string message) : base(message)
        {
        }
    }
}
