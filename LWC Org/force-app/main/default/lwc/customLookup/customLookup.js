import { LightningElement, wire } from 'lwc';
import searchRecords from '@salesforce/apex/CustomLookupController.searchRecords';

export default class CustomLookup extends LightningElement {
  searchValue = `ed`;
  objectAPI = `Account`;
  objectLabel = `Account`;
  recordIcon = `standard:account`;
  @wire (searchRecords,{objectAPIName:'$objectAPI',searchStr: '$searchValue'}) accsFromOrg;
}