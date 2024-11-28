public with sharing class ListViewDemo {


    public String AccFilterId4 { get; set; }

  private static String baseQuery = 'Select ID, Name FROM Account ORDER BY NAME ASC';
  public static String AccFilterId {get; set;}
  private static Integer pageSize = 10;

  public ListViewDemo(){}

  public static ApexPages.StandardSetController AccSetController {
        get{
            if(AccSetController == null){
                AccSetController = new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery));
                AccSetController.setPageSize(pageSize);

                // We have to set FilterId after Pagesize, else it will not work
                if(AccFilterId != null)
                {
                  AccSetController.setFilterId(AccFilterId);
                }
            }
            return AccSetController;
        }set;
    }

  public ListViewDemo(ApexPages.StandardSetController c) {   }

    //Navigate to first Page
    public void firstPage()
    {
      AccSetController.first();
    }

    public void lastPage()
    {
      AccSetController.last();
    }

    //Navigate to Next page
    public void next()
    {
      if(AccSetController.getHasNext())
      {
        AccSetController.next();
      }
    }

    //Navigate to Prev Page
    public void prev()
    {
      if(AccSetController.getHasPrevious())
      {
        AccSetController.previous();
      }
    }
    /*
@AuraEnabled
    public List<Account> getAccounts1()
    {
      return (List<Account>)AccSetController.getRecords();
    }*/
    
    @AuraEnabled
    public static List<Account> getAccounts1()
    {
       system.debug('Called here');
          system.debug('AccSetController.getRecords()--->'+AccSetController.getRecords());
      return (List<Account>)AccSetController.getRecords();
    }

    //Get all available list view for Account
    /*
    @AuraEnabled
    public List<string> getAccountExistingViews(){
        //return AccSetController.getListViewOptions();
        List<String> stringValues = new List<String>();
for(SelectOption so: AccSetController.getListViewOptions()){
    stringValues.add(so.getValue());
}
return stringValues;
    }*/
    
       @AuraEnabled
    public  static List<string> getAccountExistingViews(){
        //return AccSetController.getListViewOptions();
        List<String> stringValues = new List<String>();
for(SelectOption so: AccSetController.getListViewOptions()){
    stringValues.add(so.getlabel());
   }
return stringValues;
}
    /**
    * Reset List View
    */
    
    public static void resetFilter()
    {
    system.debug('Called page reference');
      AccSetController = null;
        AccSetController.setPageNumber(1);
     // return null;
    }
    @AuraEnabled
    public static void resetFilter1()
    {
    system.debug('Called');
      resetFilter();
    }
}