import { LightningElement, wire } from 'lwc';
import ContactSearchLMS from '@salesforce/messageChannel/ContactSearch__c';
import {publish, MessageContext} from 'lightning/messageService';

export default class ContactsearchCmp extends LightningElement {
    @wire(MessageContext)
    messageContext;

    searchKey;
     handleSearchKeyChange(event){
        this.searchKey=event.target.value;
    }
    handleSearch(event){
        const message={conSearchkey:this.searchKey};
        publish(this.messageContext,ContactSearchLMS , message);
    }
}