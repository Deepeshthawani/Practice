import { LightningElement, wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class WirePractice extends LightningElement {
    @wire(getListUi , {objectApiName: ACCOUNT_OBJECT, listViewApiName: 'AllAccounts' })
    accounts
    
    get accountList() {
        return this.accounts.data ? this.accounts.data.records.records : [];
    }

}