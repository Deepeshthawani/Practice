import { LightningElement} from 'lwc';

export default class C2pParent extends LightningElement {
    receivedData = ''
    handlehandleChildData(event){
        this.receivedData = event.detail.value
    }


}