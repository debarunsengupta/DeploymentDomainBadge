//----------------------------------------------------------
//Author: Debarun Sengupta(debsengupta@deloitte.com)
//Purpose: Test class for GenericDataTableCmpController
//********changes logs*********
//-------------------------------------------------------
@IsTest
private class GenericDataTableCmpControllerTest{

    private testmethod static void testmethod1(){
Account acc=new Account();
acc.name='test';
insert acc;
contact c=new contact();
c.accountid=acc.id;
c.lastname='test';
insert c;

List<String> FieldsAPINameList=new List<string>();
FieldsAPINameList.add('Name');
FieldsAPINameList.add('Account.Name');
List<String> columnLabelsList =new List<string>();
columnLabelsList.add('Contact name');
columnLabelsList.add('Account Name');
GenericDataTableCmpController.getAllRelatedRecords('Contact',FieldsAPINameList,columnLabelsList,'','','','100');
GenericDataTableCmpController.GetCurrencySymbolFromISO('USD');
    }
private testmethod static void testmethodsorting(){
Account acc=new Account();
acc.name='test';
insert acc;
contact c=new contact();
c.accountid=acc.id;
c.lastname='test';
insert c;

List<String> FieldsAPINameList=new List<string>();
FieldsAPINameList.add('Name');
FieldsAPINameList.add('Account.Name');
List<String> columnLabelsList =new List<string>();
columnLabelsList.add('Contact name');
columnLabelsList.add('Account Name');
GenericDataTableCmpController.getAllRelatedRecords('Contact',FieldsAPINameList,columnLabelsList,'Name','Email!=null','','100');
GenericDataTableCmpController.GetCurrencySymbolFromISO('USD');
    }

}