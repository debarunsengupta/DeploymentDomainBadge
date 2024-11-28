public class FileUploader 
{
    public string nameFile{get;set;}
    public Blob contentFile{get;set;}
    String[] filelines = new String[]{};
    public List<string> stringlist {get;set;}
    

    public Pagereference ReadFile()
    {
        try{
                //Convert the uploaded file which is in BLOB format into a string
                nameFile =blobToString(contentFile,'ISO-8859-1');
                
                //Now sepatate every row of the excel file
                filelines = nameFile.split('\n');
             
                stringlist= new List<string>();
                system.debug('filelines.size()'+filelines.size());
                 system.debug('filelines'+filelines);
                 string tagprof='';
                 string tagcustomfield='';
                 string tagapexclass='';
                 string taglayout='';
                 string tagrectype='';
                 string tagobj='';
                 string taglightning='';
                 string tagcustomlabel='';
                 string tagtab='';
                 string tagvfpage='';
                 
                 string tagcompactlayout='';
                string tagtemplate='';
                string tagletterhead='';
                string tagflexipage='';
                string tagflow='';
                string taggroup='';
                string tagpermission='';
                string tagreport='';
                
                
              string tagstandard='';
                string tagvalidation='';
                string tagweblink='';
                string tagwfalert='';
                string tagwffieldupdate='';
                string tagwfrule='';
               string tagquickaction='';
                string tagsharing='';
                string tagdashboard='';
                string tagreporttype='';
                
                string tagrole='';
                string tagbusinessprocess='';
                string taglistview='';
                string tagtrigger='';
                
                 string finalxml='';
                 system.debug('invoked');
              
                for (Integer i=1;i<filelines.size();i++) //1046
                {
                 
                    String[] inputvalues = new String[]{};
                    inputvalues = filelines[i].split(',');
                  system.debug('Comp Name-->'+inputvalues[3]);
                    system.debug('Type-->'+inputvalues[6]);
                    system.debug('Match-->'+inputvalues[6].trim().equals('Profile'));
                    /*
                    tagprof=metadatatagform('Profile',tagprof,inputvalues[6].trim(),inputvalues[3].trim());
                    tagcustomfield=metadatatagform('CustomField',tagcustomfield,inputvalues[6].trim(),inputvalues[3].trim());
                     tagapexclass=metadatatagform('ApexClass',tagapexclass,inputvalues[6].trim(),inputvalues[3].trim());
                      taglayout=metadatatagform('Layout',taglayout,inputvalues[6].trim(),inputvalues[3].trim());
                       tagrectype=metadatatagform('RecordType',tagrectype,inputvalues[6].trim(),inputvalues[3].trim());
                        tagobj=metadatatagform('CustomObject',tagobj,inputvalues[6].trim(),inputvalues[3].trim());
                        taglightning=metadatatagform('AuraDefinitionBundle',taglightning,inputvalues[6].trim(),inputvalues[3].trim());
                        tagvfpage=metadatatagform('ApexPage',tagvfpage,inputvalues[6].trim(),inputvalues[3].trim());
                        tagtab=metadatatagform('CustomTab',tagtab,inputvalues[6].trim(),inputvalues[3].trim());
                        tagcustomlabel=metadatatagform('CustomLabel',tagcustomlabel,inputvalues[6].trim(),inputvalues[3].trim());
                        tagcompactlayout=metadatatagform('CompactLayout',tagcompactlayout,inputvalues[6].trim(),inputvalues[3].trim());
                        tagtemplate=metadatatagform('EmailTemplate',tagtemplate,inputvalues[6].trim(),inputvalues[3].trim());
                        tagletterhead=metadatatagform('Letterhead',tagletterhead,inputvalues[6].trim(),inputvalues[3].trim());
                        tagflexipage=metadatatagform('FlexiPage',tagflexipage,inputvalues[6].trim(),inputvalues[3].trim());
                        tagflow=metadatatagform('Flow',tagflow,inputvalues[6].trim(),inputvalues[3].trim());
                        taggroup=metadatatagform('Group',taggroup,inputvalues[6].trim(),inputvalues[3].trim());
                        tagpermission=metadatatagform('PermissionSet',tagpermission,inputvalues[6].trim(),inputvalues[3].trim());
                        tagreport=metadatatagform('Report',tagreport,inputvalues[6].trim(),inputvalues[3].trim());
                        tagstandard=metadatatagform('StandardValueSet',tagstandard,inputvalues[6].trim(),inputvalues[3].trim());
                        tagvalidation=metadatatagform('ValidationRule',tagvalidation,inputvalues[6].trim(),inputvalues[3].trim());
                        tagweblink=metadatatagform('WebLink',tagweblink,inputvalues[6].trim(),inputvalues[3].trim());
                        tagwfalert=metadatatagform('WorkflowAlert',tagwfalert,inputvalues[6].trim(),inputvalues[3].trim());
                        tagwffieldupdate=metadatatagform('WorkflowFieldUpdate',tagwffieldupdate,inputvalues[6].trim(),inputvalues[3].trim());
                      
                        tagwfrule=metadatatagform('WorkflowRule',tagwfrule,inputvalues[6].trim(),inputvalues[3].trim());
                        tagquickaction=metadatatagform('QuickAction',tagquickaction,inputvalues[6].trim(),inputvalues[3].trim());
                        tagsharing=metadatatagform('SharingCriteriaRule',tagsharing,inputvalues[6].trim(),inputvalues[3].trim());
                        tagdashboard=metadatatagform('Dashboard',tagdashboard,inputvalues[6].trim(),inputvalues[3].trim());
                        tagreporttype=metadatatagform('ReportType',tagreporttype,inputvalues[6].trim(),inputvalues[3].trim());
                        tagbusinessprocess=metadatatagform('BusinessProcess',tagbusinessprocess,inputvalues[6].trim(),inputvalues[3].trim());
                        tagrole=metadatatagform('Role',tagrole,inputvalues[6].trim(),inputvalues[3].trim());
                        taglistview=metadatatagform('ListView',taglistview,inputvalues[6].trim(),inputvalues[3].trim());  */
                    
                     if(inputvalues[6].trim().equals('Profile') && !tagprof.equals(inputvalues[3])) 
                     {
                     system.debug('Inside');
                     system.debug('inputvalues[3] inside-->'+inputvalues[3]);
                       tagprof=tagprof+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagprof->'+tagprof);
                     }
                       if(inputvalues[6].trim().equals('CustomField') && !tagcustomfield.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside cf-->'+inputvalues[3]);
                       tagcustomfield=tagcustomfield+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagcustomfield->'+tagcustomfield);
                     }
                      if(inputvalues[6].trim().equals('ApexClass') && !tagapexclass.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagapexclass=tagapexclass+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagapexclass->'+tagapexclass);
                     }
                      if(inputvalues[6].trim().equals('Layout') && !taglayout.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       taglayout=taglayout+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('taglayout->'+taglayout);
                     }
                        if(inputvalues[6].trim().equals('RecordType') && !tagrectype.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagrectype=tagrectype+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagrectype->'+tagrectype);
                     }
                        if(inputvalues[6].trim().equals('CustomObject') && !tagobj.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagobj=tagobj+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagobj);
                     }
                          if(inputvalues[6].trim().equals('AuraDefinitionBundle') && !taglightning.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       taglightning=taglightning+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+taglightning);
                     }
                       if(inputvalues[6].trim().equals('ApexPage') && !tagvfpage.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagvfpage=tagvfpage+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagvfpage);
                     }
                        if(inputvalues[6].trim().equals('CustomTab') && !tagtab.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagtab=tagtab+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagtab);
                     }
                     if(inputvalues[6].trim().equals('CustomLabel') && !tagcustomlabel.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagcustomlabel=tagcustomlabel+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagcustomlabel);
                     }
                   
                       if(inputvalues[6].trim().equals('CompactLayout') && !tagcompactlayout.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagcompactlayout=tagcompactlayout+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagcompactlayout);
                     }
                    if(inputvalues[6].trim().equals('EmailTemplate') && !tagtemplate.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagtemplate=tagtemplate+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagtemplate);
                     }
                        if(inputvalues[6].trim().equals('Letterhead') && !tagletterhead.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagletterhead=tagletterhead+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagletterhead);
                     }
                        if(inputvalues[6].trim().equals('FlexiPage') && !tagflexipage.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagflexipage=tagflexipage+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagflexipage);
                     }
                        if(inputvalues[6].trim().equals('Flow') && !tagflow.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagflow=tagflow+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagflow);
                     }
                        if(inputvalues[6].trim().equals('Group') && !taggroup.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       taggroup=taggroup+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+taggroup);
                     }
                        if(inputvalues[6].trim().equals('PermissionSet') && !tagpermission.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagpermission=tagpermission+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagpermission);
                     }
                        if(inputvalues[6].trim().equals('Report') && !tagreport.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagreport=tagreport+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagreport);
                     }
                     
                        if(inputvalues[6].trim().equals('StandardValueSet') && !tagstandard.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagstandard=tagstandard+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagstandard);
                     }
                        if(inputvalues[6].trim().equals('ValidationRule') && !tagvalidation.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagvalidation=tagvalidation+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagvalidation);
                     }
                        if(inputvalues[6].trim().equals('WebLink') && !tagweblink.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagweblink=tagweblink+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagweblink);
                     }
                        if(inputvalues[6].trim().equals('WorkflowAlert') && !tagwfalert.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagwfalert=tagwfalert+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagwfalert);
                     }
                        if(inputvalues[6].trim().equals('WorkflowFieldUpdate') && !tagwffieldupdate.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagwffieldupdate=tagwffieldupdate+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagwffieldupdate);
                     }
                     
    
                        
                    
                      if(inputvalues[6].trim().equals('WorkflowRule') && !tagwfrule.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagwfrule=tagwfrule+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagwfrule);
                     }
                        if(inputvalues[6].trim().equals('QuickAction') && !tagquickaction.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagquickaction=tagquickaction+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagquickaction);
                     }
                        if(inputvalues[6].trim().equals('SharingCriteriaRule') && !tagsharing.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagsharing=tagsharing+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagsharing);
                     }
                        if(inputvalues[6].trim().equals('Dashboard') && !tagdashboard.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagdashboard=tagdashboard+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagdashboard);
                     }
                        if(inputvalues[6].trim().equals('ReportType') && !tagreporttype.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagreporttype=tagreporttype+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagreporttype);
                     }
                        if(inputvalues[6].trim().equals('BusinessProcess') && !tagbusinessprocess.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagbusinessprocess=tagbusinessprocess+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagbusinessprocess);
                     }
                            if(inputvalues[6].trim().equals('Role') && !tagrole.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagrole=tagrole+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagrole);
                     }
                     
                            if(inputvalues[6].trim().equals('ListView') && !taglistview.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       taglistview=taglistview+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+taglistview);
                     }
                     if(inputvalues[6].trim().equals('ApexTrigger') && !tagtrigger.equals(inputvalues[3])) 
                     {
                     system.debug('Inside cf');
                     system.debug('inputvalues[3] inside class-->'+inputvalues[3]);
                       tagtrigger=tagtrigger+'<members>'+inputvalues[3].trim()+'</members>'+'\n';
                       system.debug('tagobj->'+tagtrigger);
                     }
                
                     
                     
                        
                      
                }
                 //tag=tag+'<name>Profile</name>';
          
                finalxml=metaxmltagfinalform('Profile',tagprof,finalxml);
                finalxml=metaxmltagfinalform('CustomField',tagcustomfield,finalxml);
                finalxml=metaxmltagfinalform('ApexClass',tagapexclass,finalxml);
                finalxml=metaxmltagfinalform('Layout',taglayout,finalxml);
                finalxml=metaxmltagfinalform('RecordType',tagrectype,finalxml);
                finalxml=metaxmltagfinalform('CustomObject',tagobj,finalxml);
                finalxml=metaxmltagfinalform('AuraDefinitionBundle',taglightning,finalxml);
                finalxml=metaxmltagfinalform('ApexPage',tagvfpage,finalxml);
                finalxml=metaxmltagfinalform('CustomTab',tagtab,finalxml);
                finalxml=metaxmltagfinalform('CustomLabel',tagcustomlabel,finalxml);
                finalxml=metaxmltagfinalform('CompactLayout',tagcompactlayout,finalxml);
                finalxml=metaxmltagfinalform('EmailTemplate',tagtemplate,finalxml);
                finalxml=metaxmltagfinalform('Letterhead',tagletterhead,finalxml);
                finalxml=metaxmltagfinalform('FlexiPage',tagflexipage,finalxml);
                finalxml=metaxmltagfinalform('Flow',tagflow,finalxml);
                finalxml=metaxmltagfinalform('Group',taggroup,finalxml);
                finalxml=metaxmltagfinalform('PermissionSet',tagpermission,finalxml);
                finalxml=metaxmltagfinalform('Report',tagreport,finalxml);
                finalxml=metaxmltagfinalform('StandardValueSet',tagstandard,finalxml);
                finalxml=metaxmltagfinalform('ValidationRule',tagvalidation,finalxml);
                finalxml=metaxmltagfinalform('WebLink',tagweblink,finalxml);
                finalxml=metaxmltagfinalform('WorkflowAlert',tagwfalert,finalxml);
                finalxml=metaxmltagfinalform('WorkflowFieldUpdate',tagwffieldupdate,finalxml);
                finalxml=metaxmltagfinalform('WorkflowRule',tagwfrule,finalxml);
                finalxml=metaxmltagfinalform('QuickAction',tagquickaction,finalxml);
                finalxml=metaxmltagfinalform('SharingCriteriaRule',tagsharing,finalxml);
                finalxml=metaxmltagfinalform('Dashboard',tagdashboard,finalxml);
                finalxml=metaxmltagfinalform('ReportType',tagreporttype,finalxml);
                finalxml=metaxmltagfinalform('BusinessProcess',tagbusinessprocess,finalxml);
                finalxml=metaxmltagfinalform('Role',tagrole,finalxml);
                finalxml=metaxmltagfinalform('ListView',taglistview,finalxml);
                finalxml=metaxmltagfinalform('ApexTrigger',tagtrigger,finalxml);
                finalxml='<?xml version="1.0" encoding="UTF-8"?>'+'\n'+'<Package xmlns="http://soap.sforce.com/2006/04/metadata">'+'\n'+finalxml+'<version>43.0</version>'+'\n'+'</Package>'+'\n';

                 //finalxml=finalxml+tagprof+'<name>Profile</name>'+'\n'+tagcustomfield+'<name>CustomField</name>'+'\n'+tagapexclass+'<name>ApexClass</name>'+'\n'+taglayout+'<name>Layout</name>'+'\n'+tagrectype+'<name>RecordType</name>'+'\n'+tagobj+'<name>CustomObject</name>'+'\n';
                 stringlist.add(finalxml);
                system.debug('stringlist-->'+stringlist);
         }
         catch(Exception e){
                 ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured reading the CSV file'+e.getMessage()+':'+e.getlinenumber());
                ApexPages.addMessage(errormsg);
         }       
         
        return null;
    }
   
   /**** This function sends back to the visualforce page the list of account records that were inserted ****/ 
    public string getxml()
    {
    system.debug('called');
   
        if (stringlist!= NULL)
            if (stringlist.size() > 0)
            {
            system.debug('stringlist----called>'+stringlist);
            string fullone=String.join(stringlist, ',');
            fullone=fullone.removeStart('[');
             fullone=fullone.removeend(']');
            return fullone;
                //return stringlist;
                }
            else
                return null;                    
        else
            return null;
    }  
    
    public string metadatatagform(string comptype,string tagtype,string val6,string val3)
    {
        if(val6.equals(comptype) && !tagtype.contains(val3)) 
                     {
                     system.debug('Inside');
                     //system.debug('inputvalues[3] inside-->'+inputvalues[3]);
                       tagtype=tagtype+'<members>'+val3+'</members>'+'\n';
                       system.debug('tagprof->'+tagtype);
                     }
                     return tagtype;
        
    }
    
      public string metaxmltagfinalform(string comptype,string tagtype,string finalxml)
    {
        if(tagtype !='')
                 {
                  //finalxml=finalxml+tagtype+'<name>'+comptype+'</name>'+'\n';
                  finalxml=finalxml+'<types>'+'\n'+tagtype+'<name>'+comptype.trim()+'</name>'+'\n'+'</types>'+'\n';
                 }
                     return finalxml;
        
    }
        /**
         This function convers the input CSV file in BLOB format into a string
        @param input    Blob data representing correct string in @inCharset encoding
        @param inCharset    encoding of the Blob data (for example 'ISO 8859-1')
     */
    public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }         
}