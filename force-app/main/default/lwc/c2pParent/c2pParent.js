import { LightningElement,api } from 'lwc';

export default class C2pParent extends LightningElement {
    receivedData = ''
    @api handlehandleChildData(event){
        this.receivedData = event.detail.value
    }


}