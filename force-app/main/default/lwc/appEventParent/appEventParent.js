import { LightningElement, wire, track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';

export default class AppEventParent extends LightningElement {
   // @track inpVal;
    @track attr1;
    @track attr2;
    @wire(CurrentPageReference) pageRef;
    
    connectedCallback(){
        registerListener('testing', this.testingFn, this);
    }

    testingFn(param){
        console.log('Passed Val-->'+JSON.stringify(param));
        this.attr1=param.attr1;
        this.attr2=param.attr2;
    }

    disconnectedCallback(){
        unregisterAllListeners(this);
    }
}