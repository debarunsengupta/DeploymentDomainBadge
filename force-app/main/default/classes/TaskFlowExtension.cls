public with sharing class TaskFlowExtension {

    public TaskFlowExtension(ApexPages.StandardSetController controller) {

    }

    public final Flow.Interview.ActualFlow createContractFromAccount {get; set;}
    public TaskFlowExtension(ApexPages.StandardController stdController) {}
    public String getFinishLoc() { 
         return  'home/home.jsp'; 
    }
     Public PageReference getFinishPageRef(){
        PageReference pageRef = new PageReference('/' + getfinishLoc());
        pageRef.setRedirect(true);
        return pageRef;
    }
}