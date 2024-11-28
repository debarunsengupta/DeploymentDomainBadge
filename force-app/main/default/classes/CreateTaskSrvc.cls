@RestResource(urlMapping='/createTask/*')
global with sharing class CreateTaskSrvc{
    @HttpGet
    global static String doGet(){
        
        String oppName = RestContext.request.params.get('oppName');
        String taskSubject = RestContext.request.params.get('taskSubject');
        String taskPriority = RestContext.request.params.get('taskPriority');
        String resp = '';
        
        if(String.isBlank(taskSubject) || taskSubject == 'undefined'){
            resp = 'You need to mention the subject for the task. Just repeat what you said along with the subject.';
        }
        else{
            if(String.isBlank(taskPriority) || taskPriority == 'undefined'){
                resp = 'Note that as you have not mentioned the priority for the task it would be set to Normal by default.';
            }
            
            try{
                List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE Name =: oppName ORDER BY LastModifiedDate DESC];
                if(!oppList.isEmpty()){
                    Task t = new Task();
                    t.Subject = taskSubject;
                    t.Status = 'Open';
                    if(!String.isBlank(taskPriority)){
                        t.Priority = taskPriority.capitalize();
                    }
                    else{
                        t.Priority = 'Normal';
                    }
                    t.WhatId = oppList[0].ID;
                    insert t;
                
                    if(oppList.size()>1){
                        resp += ' Could find more than one Opportunity with the name ' + oppName + ' ' + taskSubject.capitalize() + ' task has been created on the most recently created Opportunity named ' + oppName + '.'; 
                    }
                    else if(oppList.size() == 1){
                        resp += ' ' + taskSubject.capitalize() + ' Task has been created on ' + oppName + ' Opportunity.';
                    }
                }
            }
            catch(Exception e){
                System.debug(e.getStackTraceString());
                resp = 'An exception occured. Please report this issue to your admin team.';
            }
        }
        
        return resp;
    }
}