public class GoogleOpenIdRegistrationHandler implements Auth.RegistrationHandler{
    public User createUser(Id portalId, Auth.UserData data){
        //get a user with the same email as the Open Id user
        User u = [SELECT Id FROM User WHERE federationidentifier = :data.email LIMIT 1];
        return u;
    }
    public void updateUser(Id userId, Id portalId, Auth.UserData data){
        //todo: we can do something when they login if needed
    }
}