import { LightningElement } from 'lwc';
import pubsub from 'c/pubSub';

export default class PubSubCompA extends LightningElement {
    input = '';

    handleInput(event) {
        this.input = event.detail.value;
    }

    handleClick() {
        console.log(this.input);
        pubsub.publish('messageFromCompA', this.input);
        console.log('published Comp A');
    }
}
