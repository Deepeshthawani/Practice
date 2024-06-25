import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ToastEventExample extends LightningElement {

    showToast() {
        // const element = this.template.querySelector('.my-element');
        const event = new ShowToastEvent({
            title: 'Success!',
            message: 'Your action was successful. Click {0} to view details.',
            messageData: [
                {
                url: 'https://google.com',
                label: 'here'
                }
            ],
            variant: 'success',
        });
        this.dispatchEvent(event);
    }

}