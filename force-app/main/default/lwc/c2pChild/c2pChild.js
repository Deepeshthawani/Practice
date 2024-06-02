import { LightningElement } from 'lwc';

export default class C2pChild extends LightningElement {
    inputText=''

    handleInputHandler(event){
        this.inputText = event.detail.value
    }

    handleClick(){
        this.dispatchEvent(new CustomEvent('sendevent', {
            detail : this.inputText
        }))
    }
}