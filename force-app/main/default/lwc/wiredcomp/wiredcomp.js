import { LightningElement,api,wire,track } from 'lwc';

export default class Wiredcomp extends LightningElement {

    constructor(){
        super();
        console.log('<!-- Constructor Called -->');
    }

    connectedCallback(){
        console.log('<!-- connectedCallback Called -->');
    }

    renderedCallback(){
        console.log('<!-- renderedCallback Called -->');
    }

    disconnectedCallback(){
        console.log('<!-- disconnectedCallback Called -->');
    }




}