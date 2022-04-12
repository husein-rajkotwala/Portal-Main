using System.Web.UI;

public enum Operator { And, Or };
public enum SortType { Ascending, Descending };
public delegate string FindControlValueDelegate(Control parent, string controlID);