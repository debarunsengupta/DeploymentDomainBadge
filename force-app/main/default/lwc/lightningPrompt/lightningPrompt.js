/*
MIT License

Copyright (c) 2020 Playground, https://www.playg.app

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
import { LightningElement, api } from 'lwc';

export default class LightningPrompt extends LightningElement {
    @api header;
    @api message;
    @api type = 'info';
    @api buttons;
    @api show;
    @api context;
    headerClass = 'slds-modal__header {0} slds-theme_alert-texture';

    connectedCallback() {
        if (this.type === 'info') {
            this.headerClass = this.headerClass.replace('{0}', 'slds-theme_info');
        } else if (this.type === 'error') {
            this.headerClass = this.headerClass.replace('{0}', 'slds-theme_error');
        } else if (this.type === 'warning') {
            this.headerClass = this.headerClass.replace('{0}', 'slds-theme_warning');
        } else if (this.type === 'offline') {
            this.headerClass = this.headerClass.replace('{0}', 'slds-theme_offline');
        }
    }

    renderedCallback() {
        if (this.show) {
            this.template.querySelector('.header-container').innerHTML = this.header;
            this.template.querySelector('.message-container').innerHTML = this.message;
        }
    }

    handleClick(event) {
        let button = event.target.dataset.id;
        this.dispatchEvent(new CustomEvent('promptaction', { detail: { type: this.type, button: button, context: this.context } }));
    }
}