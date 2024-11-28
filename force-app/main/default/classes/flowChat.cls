global class flowChat implements Process.Plugin { 

// The main method to be implemented. The Flow calls this at runtime.
global Process.PluginResult invoke(Process.PluginRequest request) { 
        // Get the subject of the Chatter post from the flow
        String subject = (String) request.inputParameters.get('subject');
        
        // Use the Chatter APIs to post it to the current user's feed
        FeedItem fItem = new FeedItem(); 
        fItem.ParentId = UserInfo.getUserId(); 
        fItem.Body = 'Force.com flow Update: ' + subject; 
        insert fItem; 

        // return to Flow
        Map<String,Object> result = new Map<String,Object>(); 
        return new Process.PluginResult(result); 
    } 

    // Returns the describe information for the interface
    global Process.PluginDescribeResult describe() { 
        Process.PluginDescribeResult result = new Process.PluginDescribeResult(); 
        result.Name = 'flowchatplugin';
        result.Tag = 'chat';
        result.inputParameters = new 
           List<Process.PluginDescribeResult.InputParameter>{ 
               new Process.PluginDescribeResult.InputParameter('subject', 
               Process.PluginDescribeResult.ParameterType.STRING, true) 
            }; 
        result.outputParameters = new 
           List<Process.PluginDescribeResult.OutputParameter>{ }; 
        return result; 
    }
}