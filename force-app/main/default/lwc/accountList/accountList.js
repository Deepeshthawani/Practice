import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class AccountList extends LightningElement {
    @track accounts
    @track error

    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Industry', fieldName: 'Industry' },
    ];
    
    handleClick(){
        this.fetchAccounts()
    }

    fetchAccounts(){
        getAccounts()
        .then(result => {
            this.accounts = result
            this.error = undefined
        })
        .catch(error => {
            this.accounts=undefined
            this.error=error
        })
    }
}