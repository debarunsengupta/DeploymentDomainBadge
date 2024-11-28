public class AccExt{
   
    public List<Account> accList {get;set;}
    private ApexPages.StandardSetController standardController;
    private Set<Id> accIds = new Set<Id>();

    public AccExt(ApexPages.StandardSetController standardController){
        system.debug('aaa');
        this.standardController = standardController;
        accList = new List<Account>();
        for (Account mem : (List<Account>)standardController.getSelected()){ 
            accIds .add(mem.Id);
        }
        accList = [SELECT Name FROM Account WHERE ID IN: accIds ];
    }
}