import { LightningElement, wire } from 'lwc';
import getContactsDetails from '@salesforce/apex/LWCController.getContactsDetails';
import ContactSearchLMS from '@salesforce/messageChannel/ContactSearch__c';
import {subscribe,unsubscribe, MessageContext} from 'lightning/messageService';

export default class ContactSearchResults extends LightningElement {
    searchKey;
    subscribtion;
    
    @wire(MessageContext)
    messageContext;

    @wire(getContactsDetails, {searchKey:'$searchKey'})
    contacts;
    

    connectedCallback(){
        
        if(!this.subscribtion){
            this.subscribtion=subscribe(this.messageContext,
                    ContactSearchLMS ,
                    (message)=>{
                        this.handleMessage(message);
                    });
        }
    }
    disconnectedCallback(){
        console.log('disconnectedCallback');
        unsubscribe(this.subscribtion);
        this.subscribtion=null;
    }
    handleMessage(message){
        
        this.searchKey=message? (message.conSearchkey):null;
        console.log('searchKey:'+this.searchKey);
    }



}