/** Class Name   : classicRegionTreeCntl 
*  Description  : This controller is used to create Region Tree to display in lightning component
*  Created By   : Veera k 
*  Created On   : 17th June 2018
*
*  Modification Log:  
*  --------------------------------------------------------------------------------------------------------------------------------------
*   Developer                Date                   Modification ID      Description 
*  ---------------------------------------------------------------------------------------------------------------------------------------
**/
public class classicRegionTreeCntl {
    
    @AuraEnabled
    public static List<classicTreeWrapper> init(){
        
        List<UserRole> allRoles=[SELECT DeveloperName,Id,Name,ParentRoleId FROM UserRole];        
        Map<Id,UserRole> parentRole= new Map<Id,UserRole>(); //Parent Role
        Map<Id,UserRole> childRole= new Map<Id,UserRole>();
        Map<Id,UserRole> grandChildRole= new Map<Id,UserRole>();
        Map<Id,UserRole> exceptParentRole= new Map<Id,UserRole>();        
        Map<String,List<String>> parentwithchild = new Map<String,List<String>>();  // This is Parent with child
        Map<String,List<String>> childwithGrandchild = new Map<String,List<String>>();   // This is child with grand child
        
        for(UserRole s : allRoles){
            if(s.ParentRoleId==null)
                parentRole.put(s.id,s);
            else
               exceptParentRole.put(s.id,s);
        }        
        for(UserRole t: exceptParentRole.values()){
            if(parentRole.containsKey(t.ParentRoleId)){
                childRole.put(t.id,t);
            }else{
                grandChildRole.put(t.id,t);
            }
        }
        
        for(Id oneEachCntry: parentRole.keyset()){
            String mainParentRole= parentRole.get(oneEachCntry).Name;
            List<String> allChilds= new List<String>();            
            for(Id oneEachRgn : childRole.keyset() ){
                if(childRole.get(oneEachRgn).ParentRoleId==oneEachCntry)
                    allChilds.add(childRole.get(oneEachRgn).Name);
            }
            parentwithchild.put(mainParentRole,allChilds);
        }
        
        for(Id oneEachSubCnty : childRole.keyset()){
            String childRoleName = childRole.get(oneEachSubCnty).Name;            
            List<String> allgrandChilds= new List<String>(); 
            for(Id oneEachSubRgn : grandChildRole.keyset() ){
                if(grandChildRole.get(oneEachSubRgn).ParentRoleId==oneEachSubCnty)
                    allgrandChilds.add(grandChildRole.get(oneEachSubRgn).Name);
            }            
            childwithGrandchild.put(childRoleName,allgrandChilds);
        }  
        
        List<classicTreeWrapper> myFinalList = new List<classicTreeWrapper>();
        for(String myMainCntry : parentwithchild.KeySet()){ 
            classicTreeWrapper oneWrap = new classicTreeWrapper();
            oneWrap.mainRole  = myMainCntry ; 
            List<classicTreeInnerWrapper>  myInnerWr= new List<classicTreeInnerWrapper>(); 
            for(String dumpRggn : parentwithchild.get(myMainCntry)){
                classicTreeInnerWrapper oneInnerWrap = new classicTreeInnerWrapper();
                oneInnerWrap.childRoleName = dumpRggn ;
                oneInnerWrap.grandchildRole = childwithGrandchild.get(dumpRggn);
                myInnerWr.add(oneInnerWrap);
            }
            oneWrap.childRole =myInnerWr;           
            myFinalList .add(oneWrap);        
        }
        return myFinalList;
    }
    
}