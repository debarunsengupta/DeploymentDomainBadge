public with sharing class AccountPagination {
    private final Account acct;  

    // The constructor passes in the standard controller defined
    // in the markup below
    public AccountPagination(ApexPages.StandardSetController controller) {
        this.acct = (Account)controller.getRecord(); 
    }    
    
    public ApexPages.StandardSetController accountRecords {
        get {
            if(accountRecords == null) {
                accountRecords = new ApexPages.StandardSetController(
                    Database.getQueryLocator([SELECT id,Name,industry,rating FROM Account WHERE Id NOT IN 
                        (SELECT AccountId FROM Opportunity WHERE IsClosed = true)]));
            }
            system.debug('accountRecords---->'+accountRecords);
            system.debug('accountRecords get records---->'+accountRecords.getRecords().size());
            system.debug('accountRecords get record---->'+accountRecords.getRecord());

            return accountRecords;
        }
        private set;
    }
    public List<Object> getAccountPagination() {
         return (List<object>) accountRecords.getRecords();
    }  
}