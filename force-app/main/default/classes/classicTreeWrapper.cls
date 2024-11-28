/*
* Purpose: This is Wrapper Class for Classic Region Tree functionality   
* Created By: Veera k 17/06/2018 
* Last Modified By: 
* Current Version:  v1.0 
* Revision Log:  
*              v1.1 - 
*              v1.0 -           
*/
public class classicTreeWrapper {
    
        @AuraEnabled  public String mainRole {get;set;}
        @AuraEnabled  public List<classicTreeInnerWrapper> childRole {get;set;} 
         public classicTreeWrapper(){              
                childRole = new List<classicTreeInnerWrapper>();            
         }
}