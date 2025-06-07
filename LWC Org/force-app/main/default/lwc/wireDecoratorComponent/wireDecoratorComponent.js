import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

const columns = [
  { label: 'Account Name', fieldName: 'Name' },
  { label: 'Website', fieldName: 'Website', type: 'url' },
  { label: 'Phone', fieldName: 'Phone', type: 'phone' },
  { label: 'Industry', fieldName: 'Industry' },
  { label: 'Billing City', fieldName: 'BillingCity'},
  { label: 'Billing State', fieldName: 'BillingState'},
  { label: 'Billing Street', fieldName: 'BillingStreet' },
  { label: 'Billing Country', fieldName: 'BillingCountry' },
  { label: 'Number Of Employees', fieldName: 'NumberOfEmployees', },
  { label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency' },
];
const columns1 = [
  { label: 'Account Name', fieldName: 'Name' },
  { label: 'Website', fieldName: 'Website', type: 'url' },
  { label: 'Phone', fieldName: 'Phone', type: 'phone' },
  { label: 'Industry', fieldName: 'Industry' },
  { label: 'Account Rating', fieldName: 'Rating' }];

export default class WireDecoratorComponent extends LightningElement {
  @wire (getAccounts) accountsFromApex;
  columns = columns;
  columns1 = columns1;
  accHot;
  error;
  @wire (getAccounts) accs ({data,error}){
    if(data){
      let updatedAccounts = data.map((currAcc) =>{
        let updatedRecord = {};
        if(!currAcc.hasOwnProperty('Rating')){
          updatedRecord = {...currAcc, Rating:'Hot'};
        } else {
          updatedRecord = {...currAcc};
        }
        return updatedRecord;
      });
      console.log(updatedAccounts);
      this.accHot = updatedAccounts;
    } else if(error){
      console.log(error);
      this.error = error;
    }
  };
}