@isTest 
public class CircularProgressControllerTest{
    static testMethod void computePercentageTest() {
       //Account a = new Account(Name='Test Account',Opportunity_Stage__c='1111',Number_of_Contacts__c=123);
        Account a = new Account(Name='Test Account');
       insert a;
       System.assertEquals(a.name, 'Test Account');
      CircularProgressController.computePercentage('Account',string.valueof(a.id),'200','12');
    }
}