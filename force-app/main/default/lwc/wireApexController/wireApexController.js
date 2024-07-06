import { LightningElement,wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import createAccount from '@salesforce/apex/AccountController.createAccount';
export default class WireApexController extends LightningElement {
    @wire(getAccounts)
    accounts;
    
    
    /*renderedCallback(){
        createAccount({accountName:'New Accounts',annualRevenue:23000})
    }*/
    /*@wire(getAccounts)
    loadAccounts({data,error}){
        if(error){
            console.log('error',error);
        }else{
            console.log('data',data);
        }
    }*/

    /*renderedCallback(){
        getAccounts().then((data,error) => { 
            console.log(data,error);
        });
    }*/
}