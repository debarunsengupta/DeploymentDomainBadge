import { LightningElement, track } from 'lwc';

export default class LightningPromptDemo extends LightningElement {
    @track errorPrompt;
    @track infoPrompt;
    @track warningPrompt;
    @track offlinePrompt;

    error = {
        header: 'Sorry to Interrupt',
        message: 'This page has an error. You might just need to refresh it. If issue still persists, please send this error code(7491d3-88xd-5obnp034271twp) to your system admin',
        buttons:
            [
                {
                    label: "OK",
                    name: "ok",
                    variant: "neutral"
                }

            ]
    };

    info = {
        header: 'Still There?',
        message: 'For security, we log you out if you’re inactive for too long.',
        buttons:
            [
                {
                    label: "Log out now",
                    name: "logout",
                    variant: "neutral"
                },
                {
                    label: "Continue working",
                    name: "continue",
                    variant: "brand"
                }

            ]
    };

    offline = {
        header: 'Scheduled Maintenance',
        message: 'Please be advised that salesforce.com will be performing scheduled maintenance during the above time period. <br/><br/> Salesforce.com may be intermittently unavailable or slow during this period.',
        buttons:
            [
                {
                    label: "OK",
                    name: "ok",
                    variant: "neutral"
                }

            ]

    }

    warning = {
        header: 'Unusual Activity',
        message: 'You are trying to move away from your test. Please follow the exam rules',
        buttons:
            [
                {
                    label: "OK",
                    name: "ok",
                    variant: "neutral"
                }

            ]

    }

    handleClick(event) {
        let type = event.target.dataset.id;
        if (type === 'info') {
            this.infoPrompt = true;
        } else if (type === 'warning') {
            this.warningPrompt = true;
        } else if (type === 'error') {
            this.errorPrompt = true;
        } else if (type === 'offline') {
            this.offlinePrompt = true;
        }
    }

    onPromptAction(event) {
        let data = event.detail;
        if (data.type === 'error') {
            this.errorPrompt = false;
        } else if (data.type === 'warning') {
            this.warningPrompt = false;
        } else if (data.type === 'info') {
            this.infoPrompt = false;
        } else if (data.type === 'offline') {
            this.offlinePrompt = false;
        }
    }
}