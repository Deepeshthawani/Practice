import { LightningElement } from 'lwc';

export default class P2cParent extends LightningElement {
    Name
    Age

    handleName(event){
        this.Name = event.detail.value
    }

    handleAge(event){
        this.Age=event.detail.value
    }
}