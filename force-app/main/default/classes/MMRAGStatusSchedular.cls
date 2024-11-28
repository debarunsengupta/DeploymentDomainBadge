/**************************************************************************************
Apex Class Name:  MMRAGStatusSchedular
Version     : 1.0 
Created Date    : 2 NOV 2017
* @Author: Debarun Sengupta
Function    : class to call Batch Apex 
*************************************************************************************/
global class MMRAGStatusSchedular implements schedulable
{
  /**
* Methods that process Opportunities with RecordType = Anthem_Opps
* 
* @Date: 2/11/2017
* @Author: Debarun Sengupta
* 
*/
global void execute(SchedulableContext sc)
    {
    MMRAGStatusUpdate b = new MMRAGStatusUpdate(); //ur batch class
      database.executebatch(b);
    }
}