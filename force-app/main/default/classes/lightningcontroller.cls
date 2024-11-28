/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
public class lightningcontroller {
  Opportunity opportunity;
  Account account;
Contact contact ;
OpportunityContactRole role;

    
    public lightningcontroller() {}
    

   public OpportunityContactRole getRole() {
      if(role == null) role = new OpportunityContactRole();
      return role;
   }

     public Account getAccount() {
      if(account == null) account = new Account();
      return account;
   }

   public Contact getContact() {
      if(contact == null) contact = new Contact();
      return contact;
   }

   public Opportunity getOpportunity() {
      if(opportunity == null) opportunity = new Opportunity();
      return opportunity;
   }

   
   @AuraEnabled
   public static Id save(Account acc,contact con,string tit,string nj,string njpeg) {
   
   DateTime date1 = (DateTime)Json.deserialize('"'+tit+'"', DateTime.class);

       System.debug(date1);

String dateformat = 'yyyy-MM-dd HH:mm:ss:sssZ';
String abc = date1.format(dateformat,''+userinfo.getTimeZone().toString());
system.debug(abc);

      // Create the account. Before inserting, copy the contact's
      // phone number into the account phone number field.
      //account.phone = con.phone;
      //insert account;
      //string d1 = '2017-07-16T08:00:00';
      string d1 = tit;
    list<String> d2 = d1.split('-'); //[2017,07,16T.....]
system.debug('Test2-->'+d2);
    list<integer> timeComponent = new list<integer>();
Datetime dt;
string t;
    timeComponent.add(Integer.valueOf(d2[0])); //[2017]
    timeComponent.add(Integer.valueOf(d2[1])); // [07]
    timeComponent.add(Integer.valueOf(d2[2].left(2))); //[16]
    //timeComponent.add(Integer.valueOf(d2[2]));
     if(d2[2].contains('T'))
     {
      t = d2[2].substringBetween('T','.'); // [08:00:00]
    system.debug('Test1-->'+t);
    
     if(t.contains(':'))
    {
    list<String> time1 = t.split(':');
    timeComponent.add(Integer.valueOf(time1[0])); //[08]
    timeComponent.add(Integer.valueOf(time1[1]));// [00]
    timeComponent.add(Integer.valueOf(time1[2])); // [00]
    
system.debug('Test-->'+timeComponent);  

 dt = Datetime.newInstanceGmt(timeComponent[0],
                                        timeComponent[1],
                                        timeComponent[2],
                                        timeComponent[3],
                                        timeComponent[4],
                                        timeComponent[5]);  

system.debug('Test val-->'+dt); 

    }
     }
     else
     {
          dt = Datetime.newInstanceGmt(timeComponent[0],
                                        timeComponent[1],
                                        timeComponent[2]); 
     }
    


      Account acc1=new Account();
      acc1.Name=acc.Name;
      acc1.Match_Billing_Address__c=acc.Match_Billing_Address__c;
      acc1.Website=acc.Website;
      insert acc1;

      // Create the contact. Before inserting, use the id field
      // that's created once the account is inserted to create
      // the relationship between the contact and the account.
     // contact.accountId = account.id;
      //insert contact;
      //Datetime dt = DateTime.parse(tit);
      //Datetime dt=datetime.valueOf(tit);
      contact c=new contact();
      c.LastName=con.LastName;
      c.Email=con.Email;
      c.Phone=con.Phone;
      c.Accountid=acc1.id;
      
      //Datetime dt = DateTime.parse('10/14/2011 11:46 AM');
      c.Titration__c=tit;
      c.NJPEGJ__c=njpeg;
      c.NJ__c=nj;
      c.test__c=dt;
      insert c;

      // Create the opportunity. Before inserting, create 
      // another relationship with the account.
      //opportunity.accountId = account.id;
      //insert opportunity;

      // Create the junction contact role between the opportunity
      // and the contact.
     // role.opportunityId = opportunity.id;
     // role.contactId = contact.id;
      //insert role;

      // Finally, send the user to the detail page for 
      // the new opportunity.


      //PageReference opptyPage = new ApexPages.StandardController(opportunity).view();
      //opptyPage.setRedirect(true);

      return acc1.id;
   }
      @AuraEnabled
    public static List<Event> getEvents(){
    user u=[select id,contactid from user where id=: UserInfo.getUserId()];
    return [SELECT id,StartDateTime,Subject,EndDateTime FROM Event];
    }
    
    
    
   @AuraEnabled
   public static DateTime getCalendar(string idpassed) 
   {
      Contact c= [select test__c,Accountid from contact where Accountid = :idpassed];
      return c.test__c;
   }
}