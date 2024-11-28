import { LightningElement,track,api,wire } from 'lwc';
import testPlatformEvent from './testPlatformEvent.html';
import getContacts from '@salesforce/apex/ContactClass.getContactList';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } from 'lightning/empApi';
let hello1=100;
//let rendercount=0;
export default class TestPlatformEvent extends LightningElement {
    @track channelName = '/event/Test__e';
    @track isSubscribeDisabled = false;
    @track isUnsubscribeDisabled = !this.isSubscribeDisabled;
    @track testvar='hello';
    @track step=50;
    rendercount=0;
    subscription = {};
    renderednow=false;
    
    @wire (getContacts) myContacts; // this is my wired property
    // Tracks changes to channelName text field
    handleChannelName(event) {
        this.channelName = event.target.value;
    }
    abc()
    {
        
        console.log(JSON.stringify(this.myContacts.data));
        return testPlatformEvent;;
    }
    /*
    renderedCallback()
    {
        console.log('this.renderednow'+this.renderednow);
        if(!this.renderednow)
        {
     this.renderednow=true;
        }
    }*/
/*
  render()
  {
   
      console.log('render called:'+this.step);
      console.log(JSON.stringify(this.myContacts.data));
      //this.channelName=;
      this.rendercount++;
      return testPlatformEvent;
  
  }*/
    // Handles subscribe button click
    handleSubscribe() {
        // Callback invoked whenever a new event message is received
        console.log('testvar line 18:'+this.testvar);
       let i=this.testvar;
      
        
        const messageCallback = function(response) {
           console.log('testvar line 55:'+i);
           this.testvar='2';
           console.log('NEW VAL:'+this.testvar);
           this.step='100';
           console.log('NEW VAL 60:'+this.testvar);
            console.log('New message received : ', JSON.stringify(response));
            // Response contains the payload of the new message received
         
        };
          
        
        this.step=hello1;
       // this.render();
        //this.abc();
        //this.renderedCallback();
        // Invoke subscribe method of empApi. Pass reference to messageCallback
        subscribe(this.channelName, -1, 
                //alert("Hello"); 
                messageCallback
            ).then(response => {
            // Response contains the subscription information on successful subscribe call
            console.log('Successfully subscribed to : ', JSON.stringify(response.channel));
            console.log('testvar line 29:'+this.testvar);
            this.subscription = response;
            this.toggleSubscribeButton(true);
        });
    }

    // Handles unsubscribe button click
    handleUnsubscribe() {
        this.toggleSubscribeButton(false);

        // Invoke unsubscribe method of empApi
        unsubscribe(this.subscription, response => {
            console.log('unsubscribe() response: ', JSON.stringify(response));
            // Response is true for successful unsubscribe
        });
    }

    toggleSubscribeButton(enableSubscribe) {
        this.isSubscribeDisabled = enableSubscribe;
        this.isUnsubscribeDisabled = !enableSubscribe;
    }

    registerErrorListener() {
        // Invoke onError empApi method
        onError(error => {
            console.log('Received error from server: ', JSON.stringify(error));
            // Error contains the server-side error
        });
    }

}