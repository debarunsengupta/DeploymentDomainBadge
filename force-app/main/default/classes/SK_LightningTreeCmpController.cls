public class SK_LightningTreeCmpController {
    @AuraEnabled
    public static List<HierarchyData> findHierarchyData(string recId, string sObjectName, string parentFieldAPIname, string labelFieldAPIName){
        List<HierarchyData> returnValue = new List<HierarchyData>();
        string queryString = 'select id, '+labelFieldAPIName+ ' ,' +parentFieldAPIname+ ' from '+sObjectName;
        //Section to get all child account details from ultimate parent starts-------------------------
        List<String> currentParent      = new List<String>{};
        Integer level               = 0;
        Boolean endOfStructure      = false;
        //method to find ultimate parent of account
        string topMostparent = GetUltimateParentId(recId, sObjectName,parentFieldAPIname );
        currentParent.add(topMostparent);
        system.debug('**********topMostparent:'+ currentParent);
        //Loop though all children
        string finalQueryString = '';
        List<sObject> queryOutput = new List<sObject>();
        while ( !endOfStructure ){  
            if( level == 0 ){
                finalQueryString = queryString + ' where id IN : CurrentParent ORDER BY '+parentFieldAPIname +'  Limit 1000';
            } 
            else {
                finalQueryString = queryString + ' where ParentID IN : CurrentParent ORDER BY '+parentFieldAPIname+' Limit 1000';
            }
            system.debug('********finalQueryString:'+finalQueryString);
            if(finalQueryString != null && finalQueryString !=''){
                try{
                    if(Limits.getLimitQueries()-Limits.getQueries()>0){
                        queryOutput = database.query(finalQueryString);
                    }else{
                        endOfStructure = true;
                    }
                }catch(exception ex){ 
                    endOfStructure = true;
                }
            }
            if( queryOutput.size() == 0 ){
                endOfStructure = true;
            }
            else{
                currentParent.clear();
                //iterating through query output
                for ( Integer i = 0 ; i < queryOutput.size(); i++ ){
                    sobject sb= queryOutput[i];
                    currentParent.add(string.valueof(sb.get('id')) );
                    HierarchyData ss = new HierarchyData();
                    if(sb.get('id') == recId || level == 0){
                        ss.expanded = true;
                    }else{
                        ss.expanded = false;
                    }
                    ss.rec = sb;
                    returnValue.add(ss);
                 }
            }
            level++;
        }
        system.debug('**********returnValue:'+returnValue);
        return returnValue;
    }
    
    // Find the tom most element in Heirarchy  
    // @return objId
    public static String GetUltimateParentId( string recId, string sObjectName, string parentFieldAPIname ){
        Boolean top = false;
        while ( !top ) {
            string queryString = 'select id , ' +parentFieldAPIname+ ' from '+sObjectName + ' where Id =:recId LIMIT 1';
            system.debug('**********queryString GetUltimateParentId:'+queryString);
            sobject sb = database.query(queryString);
            
            if ( sb.get(parentFieldAPIname) != null ) {
                recId = string.valueof(sb.get(parentFieldAPIname));
            }else {
                top = true;
            }
        }
        return recId ;
    }

    public class HierarchyData{
        @AuraEnabled
        public sObject rec{get;set;}
        @AuraEnabled
        public boolean expanded{get;set;}
        public HierarchyData(){
            expanded = false;
        }
    }
}