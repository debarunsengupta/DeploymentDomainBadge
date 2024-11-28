import { LightningElement,wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';
export default class Child extends LightningElement {
    @wire(CurrentPageReference) pageRef;

    handleClick(event){
        let inp1=this.template.querySelector('.input1').value;
        let inp2=this.template.querySelector('.input2').value;
        //let c=inp1+inp2;
        let a={
            attr1:inp1,
            attr2:inp2
        }
      fireEvent(this.pageRef, 'testing', a);

    }
}