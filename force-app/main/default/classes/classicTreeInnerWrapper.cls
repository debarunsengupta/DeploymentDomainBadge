/*
* Purpose: This is Inner Wrapper Class for Classic Region Tree functionality   
* Created By: Veera k 17/06/2018 
* Last Modified By: 
* Current Version:  v1.0 
* Revision Log:  
*              v1.1 - 
*              v1.0 -           
*/
public class classicTreeInnerWrapper {    
        @AuraEnabled  public String childRoleName {get;set;}
        @AuraEnabled  public List<String> grandchildRole {get;set;}            
         public classicTreeInnerWrapper(){               
                grandchildRole = new List<String>();                        
         }
}