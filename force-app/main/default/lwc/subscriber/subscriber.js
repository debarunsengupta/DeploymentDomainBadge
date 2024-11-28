import { LightningElement, track, wire } from 'lwc';
import { registerListener, unregisterAllListeners } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class Subscriber extends LightningElement {
    @track details;
    @wire(CurrentPageReference) pageRef;

    connectedCallback() {
        registerListener("eventdetails", this.getMessage, this);
    }
     
    disconnectedCallback() {
        unregisterAllListeners(this);
    }

    getMessage(msg){
        this.details = msg;
    }
}