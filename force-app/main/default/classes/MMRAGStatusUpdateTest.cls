@isTest 
public class MMRAGStatusUpdateTest 
{
    static testMethod void testMethodRed() 
    {
        List<Case> lstcase= new List<Case>();
        
            Case c = new Case();
            c.Origin ='Email';
            
             insert c;
        
        //insert lstcase;
        
        
            Task t = new Task();
            t.subject ='test';
            t.MM_RAG_Status_Dependent__c=true;
            t.whatid=c.id;
            t.activitydate=system.today().addDays(2);
            
        
        
        insert t;
        
        
        Test.startTest();

            MMRAGStatusUpdate obj = new MMRAGStatusUpdate();
            DataBase.executeBatch(obj); 
            
        Test.stopTest();
    }
       static testMethod void testMethodAmber() 
    {
        List<Case> lstcase= new List<Case>();
        
            Case c = new Case();
            c.Origin ='Email';
            
             insert c;
        
        //insert lstcase;
        
        
            Task t = new Task();
            t.subject ='test';
            t.MM_RAG_Status_Dependent__c=true;
            t.whatid=c.id;
            t.activitydate=system.today().addDays(3);
            
        
        
        insert t;
        
        
        Test.startTest();

            MMRAGStatusUpdate obj = new MMRAGStatusUpdate();
            DataBase.executeBatch(obj); 
            
        Test.stopTest();
    }
           static testMethod void testMethodYellow() 
    {
        List<Case> lstcase= new List<Case>();
        
            Case c = new Case();
            c.Origin ='Email';
            
             insert c;
        
        //insert lstcase;
        
        
            Task t = new Task();
            t.subject ='test';
            t.MM_RAG_Status_Dependent__c=true;
            t.whatid=c.id;
            t.activitydate=system.today().addDays(4);
            
        
        
        insert t;
        
        
        Test.startTest();

            MMRAGStatusUpdate obj = new MMRAGStatusUpdate();
            DataBase.executeBatch(obj); 
            
        Test.stopTest();
    }
}