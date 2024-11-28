global class MyException extends Exception 

{
public static void ExceptionHandling()
{
try
{
throw new MyException('something bad happened!');
}
   catch (MyException e)
     {
     futureCreateErrorLog.createErrorRecord(e.getMessage());
    }
   
     }
     }