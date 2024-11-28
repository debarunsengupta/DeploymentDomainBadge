public class QueableApexDemo implements Queueable {
    public void execute(QueueableContext context) {
        // Your processing logic here       

        // Chain this job to next job by submitting the next job
        System.debug('Test1');
        // AsyncOptions asyncOptions = new AsyncOptions();
       // asyncOptions.MaximumQueueableStackDepth = 40;
        System.enqueueJob(new QueableApexDemo1());
        System.enqueueJob(new QueableApexDemo1());
    }
}