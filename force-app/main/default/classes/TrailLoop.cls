public class TrailLoop {
   
 
    
    //Here is a combined problem of a query that needs a filter
    //and a loop that continually calls out to the database
    public static void AllGoodThings(Account a) {
        List<Task> allMyTasks = [Select Id, status, whatId From Task where whatid=:a.id];
        List<task> tlst=new List<task>();
        for (Task t : allMyTasks) {
            
                t.status = 'Completed';
                tlst.add(t);
                //update t;
            }
            update tlst;
        }
    }