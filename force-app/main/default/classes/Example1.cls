public class Example1 {
public class CustomException extends Exception{}

    public static void exampleMethod(){
        try {
          throw new CustomException('test message');
             
        } catch (CustomException variableName) {
          // First catch block for specific exception 
          // It checks Exception in the order they are in the code
          // Exception must be the last Catch as its a general exception
         system.debug('Msg-->'+variableName);
          //Perform logic to handle exception  
        } catch (Exception e) {
          // You can have Optional additional catch statement for other exception types.
          // Note that the general exception type, 'Exception'
          // Exception must be the last catch block when it is used.
         
          //Perform logic to handle exception  
        } finally {
          // Finally block.
          // Must have a finally statement or at least one catch statement
         
          //Perform logic that must happen regardless of if exception occurs
        }
    }
}