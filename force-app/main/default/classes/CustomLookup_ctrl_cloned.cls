public with sharing class CustomLookup_ctrl_cloned {      
    public String fieldTypeForSelectedField {get;set;}     
    public list<Specification__c> listOfLookupsElement {get;set;}
    public String objectName {get;set;}
    public String fieldName {get;set;}
    public String searchByName{get;set;}
    public String searchByPhone{get;set;}
    public boolean isChecked {get;set;}
    public String phoneNumberPassToTextBox {get;set;}
    public String phoneNamePassToHdn {get;set;}

    public boolean isAllSelectCheckBox {get;set;}
    /*Controller*/
    public CustomLookup_ctrl_cloned (){
        listOfLookupsElement = new list<Specification__c>();        
    
        isAllSelectCheckBox = false;

        searchByName ='';
        phoneNumberPassToTextBox = '';
        phoneNamePassToHdn  = '';
       objectName = String.escapeSingleQuotes(ApexPages.CurrentPage().getParameters().get('oN'));
        getlistOfLookupsElement();
   }
   /*to get list of lookup element*/
   public void getlistOfLookupsElement(){
        try{ 
            listOfLookupsElement = new list<Specification__c>();
            String query = 'SELECT Name,isChecked__c FROM Specification__c';
            list<Specification__c> s = Database.query(query);
            //String CountryCode = null; 
           // boolean isCountryCodeAlreadyExist;       
            for(Specification__c sObj:s){ 
               
                  
                    listOfLookupsElement.add(sObj);   
                    }
                   // listOfLookupsElement.add(new PhoneNumberDetail(String.valueOf(sObj.get('Name')),CountryCode,String.valueOf(sObj.get(fieldName)),false,isCountryCodeAlreadyExist));                     
                }
           
        catch(Exception ex){
             apexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Parameter is not defined, Please contact your Administrator!'));
        }       
    }
    
    
    
    
     /*Search event*/
    public void onSearch(){
        phoneNumberPassToTextBox = '';
       // phoneNamePassToHdn  = '';
       // isAllSelectCheckBox = false;
        listOfLookupsElement = new list<Specification__c>();
        String byName = '\'%'+String.escapeSingleQuotes(searchByName) + '%\'';
       
        try{
            String query ='SELECT Name,isChecked__c  FROM  Specification__c WHERE name Like '+byName;
            list<Specification__c> s = Database.query(query); 
            for(Specification__c sObj:s)
            {
               
                   listOfLookupsElement.add(sObj);  
                }
            } 
       catch(Exception ex){
            apexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Illegal Search parameter!'));
        }       
    }
    
     public void onCheck(){
        phoneNumberPassToTextBox = '';
        phoneNamePassToHdn  = '';
      
        for(Specification__c pn:listOfLookupsElement){
            if(pn.isChecked__c)
            {
              if(objectName=='')
              {
              phoneNumberPassToTextBox += objectName+pn.Name+',';
              
               
              }  
              else
              {                 
            phoneNumberPassToTextBox += objectName+','+pn.Name+',';
              
          
               }
                    
              
            }
        }
        if(phoneNumberPassToTextBox.contains(','))
        {
        phoneNumberPassToTextBox= phoneNumberPassToTextBox.subString(0,phoneNumberPassToTextBox.Length()-1);
    
        }
    }
    

}