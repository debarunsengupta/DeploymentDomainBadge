public class contactquery{
    public List<Contact> cs{get; set;}
    public contactquery()
    {
    cs = new List<Contact>();
       for (Contact c : [Select id, Name from Contact])
       {       
           cs.add(c);
       }
    }
}