import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';

export default class Publisher extends LightningElement {
    @wire(CurrentPageReference) pageRef;

    displayMessage(){
        fireEvent(this.pageRef, "eventdetails", "Happy Learning !!!");
    }
}