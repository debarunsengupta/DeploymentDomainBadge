public class TestUserBuilder {
  private String alias = 'testUser';
  private String country = 'India';
  private String emailEncodeKey = 'UTF-8';
  private String email = 'abc@test.com';
  private String languageLocaleKey = 'en_US';
  private String localeSideKey = 'en_US';
  private String timeZonekey = 'America/Los_Angeles';
  private String userName = 'testUserName';
  private String firstName = 'testFirstName';
  private String lastName = 'testLastNAme';
  private Boolean isActive = true;
  private Id profileId;
  private Id managerId;
    
  public
      TestUserBuilder setAlias(String alias){
          this.alias = alias;
          return this;
      }

      public
      TestUserBuilder setManagerId(Id managerId){
          this.managerId = managerId;
          return this;
      }
    
      public
      TestUserBuilder setProfileId(Id profileId){
          this.profileId = profileId;
          return this;
      }
    
    public
      TestUserBuilder setCountry(String country){
          this.country = country;
          return this;
      }
    
        public
      TestUserBuilder setEmailEncodeKey(String emailEncodeKey){
          this.emailEncodeKey = emailEncodeKey;
          return this;
      }
    
        public
      TestUserBuilder setLanguageLocaleKey(String languageLocaleKey){
          this.languageLocaleKey = languageLocaleKey;
          return this;
      }
    
        public
      TestUserBuilder setTimeZonekey(String timeZonekey){
          this.timeZonekey = timeZonekey;
          return this;
      }
    
        public
      TestUserBuilder setUserName(String userName){
          this.userName = userName;
          return this;
      }
    
        public
      TestUserBuilder setFirstName(String firstName){
          this.firstName = firstName;
          return this;
      }
    
            public
      TestUserBuilder setLastName(String lastName){
          this.lastName = lastName;
          return this;
      }
    
            public
      TestUserBuilder setIsActive(Boolean isActive){
          this.isActive = isActive;
          return this;
      }
    
            public
      TestUserBuilder setLocaleSidKey(String localeSideKey){
          this.localeSideKey = localeSideKey;
          return this;
      }
    
    public User build()
    {
        User u = new User(Alias = alias,Country = country,Email = email,EmailEncodingKey = emailEncodeKey,
                         LanguageLocaleKey = languageLocaleKey,TimeZoneSidKey = timeZonekey,UserName = userName
                         ,isActive = isActive,FirstName = firstName,LastName = lastName,ProfileId = profileId,
                         ManagerId = managerId,LocaleSidKey = localeSideKey);
        return u;
    }
    
    public User buildAndSave()
    {
        User u = build();
        insert u;
        return u;
    }
}