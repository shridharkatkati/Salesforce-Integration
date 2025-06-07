import { LightningElement, wire, api} from 'lwc';
import searchRecords from '@salesforce/apex/CustomLookupController.searchRecords';
const DELAY = 300; // timeout delay in ms

export default class CustomGenericLookup extends LightningElement {
    objectAPIName = 'Account';
    searchStr = '';
    sObjectName = 'Account';
    recordIcon = 'standard:account';
    timeoutDelay;
    displayRecords = false;
    @api choosedRecord ={
        recordId:'',
        recordName:'',
    };


    @wire (searchRecords,{
        objectAPIName:'$objectAPIName',
        searchStr: '$searchStr'
    }) objectRecords;

    get isRecordSelected(){
        return this.choosedRecord.recordId === '' ? false : true;
    }
    keyupHandler(event) {
        if(this.searchStr){
            this.displayRecords = true;
        } else {
            this.displayRecords = false;
        }

        window.clearTimeout(this.timeoutDelay);
        let inputValue = event.target.value;    
        this.timeoutDelay = setTimeout(()=>{
            this.searchStr = inputValue;
        },DELAY);
        // this.searchStr = event.target.value;
    }

    recordClickHandler(event){
        let selectedRecordId = event.currentTarget.dataset.record;
        let selectedRecord = this.objectRecords.data.find(record => record.Id === selectedRecordId);
        this.choosedRecord = {
            recordId: selectedRecord.Id,
            recordName: selectedRecord.Name
        };
        this.displayRecords = false;
    }
    deselectRecord(){
        this.choosedRecord = {
            recordId: '',
            recordName: ''
        };
        this.searchStr = '';
        this.displayRecords = true;
    }
}