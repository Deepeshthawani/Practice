import { LightningElement } from 'lwc';
import pubsub from 'c/pubSub';

export default class PubSubCompB extends LightningElement {
    messageData = '';

    connectedCallback() {
        this.subscribeComponent();
    }

    subscribeComponent() {
        pubsub.subscribe('messageFromCompA', (message)=>{
            this.messageData = message;
        });
    }
}
