import { LightningElement,wire } from 'lwc';
import { subscribe,MessageContext} from 'lightning/messageService';
import SAMPLEMC from "@salesforce/messageChannel/SampleMessageChannel__c";

export default class LmsSubscribe extends LightningElement {
    publishedMessage

    @wire(MessageContext)
    context;

    connectedCallback(){
        this.subscribeMessage()
    }

    subscribeMessage(){
        subscribe(this.context, SAMPLEMC,
            (message) => {
                this.handleMessage(message)}/* ,{ scope: APPLICATION_SCOPE }*/
        );
    }

    handleMessage(message){
        this.publishedMessage = message.messageToSend
    }

}