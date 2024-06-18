import { LightningElement,wire } from 'lwc';
import { publish,MessageContext } from 'lightning/messageService';
import SAMPLEMC from "@salesforce/messageChannel/SampleMessageChannel__c";


export default class LmsPublish extends LightningElement {
    @wire(MessageContext)
    context;
    
    myMessage=''

    handleChange(event){
        this.myMessage = event.detail.value
    }

    handleClick(){
        const message = {
            messageToSend : this.myMessage
        }
        publish(this.context,SAMPLEMC,message)
    }

}