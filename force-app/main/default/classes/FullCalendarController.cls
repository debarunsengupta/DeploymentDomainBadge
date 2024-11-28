public class FullCalendarController {

public FullCalendarController()
{
string test=System.URL.getSalesforceBaseURL().tostring(); 
system.debug('URL:'+test);
}
    @AuraEnabled
    public static List<Event> getEvents(){
    user u=[select id,contactid from user where id=: UserInfo.getUserId()];
    return [SELECT id,StartDateTime,Subject,EndDateTime FROM Event];
    }
    
    @AuraEnabled
    public static List<Task> getTasks(){
      List<Task> taskreq;
        user u=[select id,contactid from user where id=: UserInfo.getUserId()];
        Profile p=[select id,Name from profile where id =:userinfo.getProfileId()];
        //system.debug('11111========'+u);
        //List<task> TT = [select Id,IsVisibleInSelfService,whoid,Task_Reminder_Type__c,Subject,End_Time__c, Start_Date__c,ActivityDate,Whatid from Task Where whoid=:u.Contactid and Task_Reminder_Type__c in ('Hydration Reminder','Lab Appointments','Nurse Visit Appointments') and ActivityDate!=null];
        //system.debug('22222========'+TT);
        
        taskreq=[select Id,Subject,ActivityDate from Task Where whoid=:u.Contactid and ActivityDate!=null];
        
        return taskreq;
    }
     @AuraEnabled
   public static DateTime getCalendar(string idpassed) 
   {
   Contact c;
   try
   {
   system.debug('Id passed-->'+ idpassed);
      c= [select test__c,Accountid from contact where Accountid = :idpassed LIMIT 1];
      }
      catch(Exception ex)
      {
      system.debug('Line no-->'+ex.getlinenumber());
      system.debug('Msg---->'+ex.getmessage());
      }
      return c.test__c;
      
   }
      @AuraEnabled
   public static void UpdateCalendar(string idpassed,Datetime dt) 
   {
   Contact c;
   try
   {
   system.debug('Id passed-->'+ idpassed);
      c= [select test__c,Accountid from contact where Accountid = :idpassed LIMIT 1];
      c.test__c=dt;
       update c;
      }
      catch(Exception ex)
      {
      system.debug('Line no-->'+ex.getlinenumber());
      system.debug('Msg---->'+ex.getmessage());
      }
    
      
   }
       
    
}