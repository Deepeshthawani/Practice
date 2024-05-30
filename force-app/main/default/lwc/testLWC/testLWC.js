import { LightningElement } from 'lwc';

export default class TestLWC extends LightningElement {
    input
    
    handleChange(event){
        this.input = event.detail.value
    }

}