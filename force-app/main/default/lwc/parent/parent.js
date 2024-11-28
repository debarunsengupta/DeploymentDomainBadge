import { LightningElement,api,track } from 'lwc';


export default class Parent extends LightningElement {
    show=true;
   constructor(){
        super();
        console.log('<!-- Constructor ParentCalled -->');
    }

    connectedCallback(){
        console.log('<!-- connectedCallback ParentCalled -->');
    }

    renderedCallback(){
        console.log('<!-- renderedCallback Parent Called -->');
    }

    disconnectedCallback(){
        console.log('<!-- disconnectedCallback ParentCalled -->');
    }
    handleClick(event){
        alert('test');
        this.show=false;

    }

}