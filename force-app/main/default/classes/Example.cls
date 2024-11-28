public class Example {

    public static void exampleMethod(){
        try {
          //Try block of code
          //Perform logic here
          Example1.exampleMethod();
             
        } catch (Exception e) {
          // You can have Optional additional catch statement for other exception types.
          // Note that the general exception type, 'Exception'
          // Exception must be the last catch block when it is used.
         system.debug('Parent Class');
          //Perform logic to handle exception  
        } finally {
          // Finally block.
          // Must have a finally statement or at least one catch statement
         
          //Perform logic that must happen regardless of if exception occurs
        }
    }
}