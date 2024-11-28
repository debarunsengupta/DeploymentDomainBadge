@isTest(SeeAllData=true)

public class TestClassUpdateOpportunity{
    static testMethod void test() {
        Database.QueryLocator QL;
        Database.BatchableContext BC;
        List<Opportunity> op= new List<Opportunity>();
        UpdateOpportunity AU = new UpdateOpportunity();
        QL = AU.start(BC);
        
        Database.QueryLocatorIterator QIT =  QL.iterator();
        while (QIT.hasNext())
        {
            Opportunity Acc = (Opportunity)QIT.next();            
            System.debug(Acc);
            op.add(Acc);
        }        
        
        AU.execute(BC, op);
        AU.finish(BC);        
    }
}