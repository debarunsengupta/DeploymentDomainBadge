/* 
 Class Name: LeadController.apxc
 Purpose : Controller class for LeadMainComponent which implements
		following functionalities
		1.Search Leads
		2.Mass Update Leads
		3.Assigning Leads to you. 
 
*/ 

public with sharing class LeadController {

    /*******************************************************************
   MethodName: getLeadRecord()
   Purpose:    Retrieves max of 50 leads to display it in component.                                                       
   Parameters: None
   Returns: List of Leads(50)
   Throws [Exceptions]: None                                                        
  ********************************************************************/

    @AuraEnabled
    public static List<Lead> getLeadRecord() {
        return [SELECT id, name, phone,status,Owner.name FROM Lead LIMIT 50];
    }
    
    
    
  /*******************************************************************
   MethodName: massUpdateLeads(String recIds,String Status)
   Purpose:    Updates the Status for the selected leads based on the parameters.
			   Due to limitations of Lightning component on passing Array as parameters
			   recIds is deserialized and added to list and later used to update the status 
			   which is available as an another parameter.
   Parameters: String recIds,String Status
   Returns: List of Leads(50)
   Throws [Exceptions]: None                                                        
  ********************************************************************/
     @AuraEnabled
    public static List<Lead> massUpdateLeads(String recIds,String Status) {
        string [] values = (String[])System.JSON.deserialize(recIds,String[].class);
        List<Lead> leadlist = new List<Lead> ();
        for(Lead l : [SELECT Id,Status,Owner.name from Lead where id IN:values]){
            l.status = Status;
            leadlist.add(l);   
        }
        update leadlist;
        return [SELECT id, name, phone,Owner.name,status FROM Lead LIMIT 50];
    }
    
    /*******************************************************************
   MethodName: massUpdateOwner(String recIds)
   Purpose:    Updates the Owner of selected leads based on the parameters.
			   Due to limitations of Lightning component on passing Array as parameters
			   recIds is deserialized and added to list and later used to update the Owner. 			  
   Parameters: String recIds
   Returns: List of Leads(50)
   Throws [Exceptions]: None                                                        
  ********************************************************************/
     @AuraEnabled
    public static List<Lead> massUpdateOwner(String recIds) {    
          string [] values = (String[])System.JSON.deserialize(recIds,String[].class);
               List<Lead> leadlist = new List<Lead> ();
        for(Lead l : [SELECT Id,Status,Owner.name from Lead where id IN:values]){
            l.OwnerId = userinfo.getUserId();
            leadlist.add(l);   
        }
        update leadlist;
        return [SELECT id, name, phone,Owner.name,status FROM Lead LIMIT 50];
    }
    
        /*******************************************************************
   MethodName: getLeadByName(String recName)
   Purpose:    Retrieves the list of leads based on the searchtext (recName)
				 			  
   Parameters: String recName
   Returns: List of Leads(50)
   Throws [Exceptions]: None                                                        
  ********************************************************************/
    @AuraEnabled
    public static List<Lead> getLeadByName(String recName) {
        String name = '%' + recName + '%';
        return [SELECT id, name, phone,Status,Owner.name FROM Lead WHERE name LIKE :name LIMIT 50];
    }
}