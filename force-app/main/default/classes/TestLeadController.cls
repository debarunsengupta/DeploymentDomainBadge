/* 
 Class Name: LeadController.apxc
 Purpose : Unit Test class for LeadMainComponent which implements
		following functionalities
		1.Search Leads
		2.Mass Update Leads
		3.Assigning Leads to you. 
 
*/ 
@isTest
public class TestLeadController {
    static testMethod void test() {
        // Creating a Test record
        Lead ld = new Lead();
        ld.LastName =  'Test';
        ld.Company = 'ABC';
        ld.Status = 'Open - Not Contacted';
        insert ld;      
        //Validating the controller methods using system.assert
        System.assert(LeadController.getLeadRecord().size()>0);
        System.assert(LeadController.getLeadByName('Test').size()>0);
        String recid = '["' +ld.id+ '"]';     
        String selectedStatus ='Working - Contacted';
        System.assert(LeadController.massUpdateOwner(recid).size()>0);
        System.assert(LeadController.massUpdateLeads(recid,selectedStatus).size()>0);
    }
}