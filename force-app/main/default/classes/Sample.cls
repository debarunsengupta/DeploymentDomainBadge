public class Sample 
{    
    public List<String> SelectedInterests {get;set;}
    public String Name {get;set;}
    
    public List<SelectOption> getInterestOptions() {
        List<SelectOption> Options = new List<SelectOption>();
        Options.add(new SelectOption('None','None'));
        Options.add(new SelectOption('Cricket','Cricket'));
        Options.add(new SelectOption('Hockey','Hockey'));
        Options.add(new SelectOption('Swimming','Swimming'));
        Options.add(new SelectOption('Rugby','Rugby'));
        return Options;
    }
    
    public void sav() {
      Specification__c Mem = new Specification__c();
       Mem.Name = Name;
        String Interests = '';
        Boolean Start = true;
        if(!SelectedInterests.isEmpty()) {           
            for(String Str : SelectedInterests) {
                if(Start) {
                    Interests = Str;
                    Start = false;
                } else {               
                    Interests = Interests + ';' + Str;
                }
            }
        }
            Mem.Details__c = Interests;
        insert Mem;
    }
}