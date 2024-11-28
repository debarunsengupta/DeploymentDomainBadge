import { LightningElement } from 'lwc';

export default class AccountData extends LightningElement {

    handleComposed = () => {
        console.log('listened in parent');
    }
    handleComposedEmbed = () => {
        console.log('listened composed embed in parent');
    }
}