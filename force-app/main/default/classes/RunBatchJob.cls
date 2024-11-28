@RestResource(urlMapping='/runBatchJob/*')
global with sharing class RunBatchJob{            
    
    @HttpGet
    global static String doGet(){
        Integer batchSz;
        String retStr = '';
        try{
            RestRequest request = RestContext.request;
            String batchClassName = RestContext.request.params.get('batchClassName');
            String batchSize = RestContext.request.params.get('batchSize');
            
            System.debug(batchClassName);
            
            batchClassName = batchClassName.replaceAll('(\\s+)', '');
            batchClassName = batchClassName.replaceAll('%20', '');
            
            
            if(batchClassName.contains('underscore') == TRUE){
                batchClassName = batchClassName.replace('underscore','_');
            }
            system.debug('clsname:'+batchClassName);
            
            if(!String.isBlank(batchSize)){
                batchSz = Integer.valueOf(batchSize);
            }
            
            List<ApexClass> cl = [SELECT Id,Name,Body FROM ApexClass where Name =: batchClassName LIMIT 1];  
            
            string batchString = 'implements';
            
            
            
            
            
            if(!cl.isEmpty() && cl[0].Body.containsIgnoreCase(batchString) && !String.isBlank(batchSize)){
                System.debug('should be here');
                Database.executeBatch((Database.Batchable<sObject>)createInstance(cl[0].Name), batchSz);
                retStr = 'Pass';
            }
            else if(!cl.isEmpty() && String.isBlank(batchSize)){
                retStr = 'Pass';
            }
            else if(cl.isEmpty()){
                retStr = 'Fail';
            }
        }
        catch(Exception e){
            System.debug(e.getStackTraceString());
            retStr = 'An exception occured. Please report this issue to your admin team.';
        }
        
        return retStr;
    }
    
    public Static Object createInstance(String clz) {
        Type typ = Type.forName(clz);
        Object instance = null;
        if (typ != null) {
            instance = typ.newInstance();
        }
    
        if (instance == null) {
            //throw new BusinessException('Couldn\'t successfully instantiate an object for class ' + clz + '. Please check if Class name is correct, is compilable and current user has access.');
        }

        return instance;
    }
    
}