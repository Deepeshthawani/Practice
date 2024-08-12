import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class TestDataTable extends LightningElement {
    @track accounts
    @track error
    
    
    columns = [
        {label:'Name' , fieldName:'Name'},
        { label: 'Industry', fieldName: 'Industry' },
    ]

    handleClick(){
        this.fetchAccounts()
    }

    fetchAccounts(){
        getAccounts()
        .then(result => {
            this.accounts = result
            this.error = undefined
        })

        .catch(result => {
            this.error = result
            this.accounts = undefined
        })
    }
}