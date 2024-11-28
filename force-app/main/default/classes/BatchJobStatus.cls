@RestResource(urlMapping='/BatchJobStatus/*')
global with sharing class BatchJobStatus {            

@HttpGet
global static String doGet(){
    String ret = '';
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    String s;
    String clsname = RestContext.request.params.get('batchClassName');
    if(clsname.contains(' ') || clsname.contains('%20'))
    {
        s = clsname.replaceAll('(\\s+)', '');
    }
    if(clsname.Contains('underscore'))
    {
        s = s.replaceAll('underscore','_');
    }
    clsname = s;
      try{
        List<ApexClass> cl=[select id,name from Apexclass where name=: clsname limit 1];  
        if(!cl.isEmpty()){
            List<AsyncApexJob> job=[SELECT 
                                     Id, 
                                     JobType, 
                                     ApexClassId, 
                                     Status, 
                                     JobItemsProcessed, 
                                     TotalJobItems, 
                                     NumberOfErrors 
                                    FROM
                                     AsyncApexJob 
                                    where 
                                     ApexClassId=:cl[0].id  
                                    order by createddate 
                                    desc 
                                    limit 1];
            
            if(!job.isEmpty()){
                ret = job[0].Status;
            }
            else{
                ret = 'There are no batch jobs for class '+ clsname;
            }
        }
        else{
            ret = 'There are no class with this name';
        }
    }
    catch(exception ex){
        system.debug('***NOT CONVERTED**');           
    }
    return ret;
    }
}