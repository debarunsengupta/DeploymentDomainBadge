/*
	Name: lrc_data_factory
	Description: This class will be used to created dummy data for testclasses.
*/
public class lrc_data_factory {
    //Creating account instance
    public static Account init_account(string sName){
       return new Account(Name = sName);
    } 
    //Creating opportunity instance
    public static Opportunity init_opportunity(string sName){
        return new Opportunity(Name = sName);
    }
}