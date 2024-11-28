/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
public class CommunitiesSelfRegController1 {
  Opportunity opportunity;
  Account account;
Contact contact ;
OpportunityContactRole role;

    public String firstName {get; set;}
    public String lastName {get; set;}
    public String email {get; set;}
    public String password {get; set {password = value == null ? value : value.trim(); } }
    public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }
    public String communityNickname {get; set { communityNickname = value == null ? value : value.trim(); } }
    
    public CommunitiesSelfRegController1() {}
    
    private boolean isValidPassword() {
        return password == confirmPassword;
    }
// The next three methods control navigation through
   // the wizard. Each returns a PageReference for one of the three pages
   // in the wizard. Note that the redirect attribute does not need to
   // be set on the PageReference because the URL does not need to change
   // when users move from page to page.
   public PageReference step1() {
      return Page.opptyStep1;
   }

   public PageReference step2() {
      return Page.opptyStep2;
   }

   public PageReference step3() {
      return Page.opptyStep3;
   }
   public OpportunityContactRole getRole() {
      if(role == null) role = new OpportunityContactRole();
      return role;
   }
    // This method cancels the wizard, and returns the user to the 
   // Opportunities tab
    public PageReference cancel() {
            PageReference opportunityPage = new ApexPages.StandardController(opportunity).view();
            opportunityPage.setRedirect(true);
            return opportunityPage; 
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
    public PageReference registerUser() {
    
        // it's okay if password is null - we'll send the user a random password in that case
        /*if (!isValidPassword()) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
            ApexPages.addMessage(msg);
            return null;
        }  */ 

        String userName = email;

        //String profileId = '00e28000001Nxkn';
    
        String userId;
		string msg;
        
        try {
            //userId = Site.createExternalUser(u, accountId, password);
            Faculty__c c=new Faculty__c();
            c.Name='test';
            c.FacultyName__c='Hello';
            insert c;
        } 
        catch(Exception ex){

            String errorMsg = ex.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMsg));

			return Page.CustomReg;
        }
        
        system.debug('@@ userId -> '+ userId );
        
        /*if (userId != null) { 
            if (password != null && password.length() > 1) {
                return Site.login(userName, password, ApexPages.currentPage().getParameters().get('startURL'));
            }
            else {
                PageReference page = System.Page.CommunitiesSelfRegConfirm;
                page.setRedirect(true);
                return page;
            }
        }
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, msg));
		*/
		
    	return Page.CustomReg;

    }
    // This method performs the final save for all four objects, and
   // then navigates the user to the detail page for the new
   // opportunity.
   public PageReference save() {

      // Create the account. Before inserting, copy the contact's
      // phone number into the account phone number field.
      account.phone = contact.phone;
      insert account;

      // Create the contact. Before inserting, use the id field
      // that's created once the account is inserted to create
      // the relationship between the contact and the account.
      contact.accountId = account.id;
      insert contact;

      // Create the opportunity. Before inserting, create 
      // another relationship with the account.
      opportunity.accountId = account.id;
      insert opportunity;

      // Create the junction contact role between the opportunity
      // and the contact.
      role.opportunityId = opportunity.id;
      role.contactId = contact.id;
      insert role;

      // Finally, send the user to the detail page for 
      // the new opportunity.


      PageReference opptyPage = new ApexPages.StandardController(opportunity).view();
      opptyPage.setRedirect(true);

      return opptyPage;
   }
}