import { LightningElement } from 'lwc';

export default class C2pParent extends LightningElement {
    receivedData= ''

    handleChildData(event){
        console.log('Data from child received');
        this.receivedData = event.detail
    }
}