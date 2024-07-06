import { LightningElement } from 'lwc';

export default class FilterLwc extends LightningElement {
    editFilterIndex;
    editFilter = false ; 
    fltFieldDatatype;
    queryList;
    options;
    SFFields;
    LabelSFFields;
    filterQuery;
    selectedSFValue;
    SFfieldswithout__c;
    fltField = false;
    selectedSFLabel;
    ListOperator;
    selectedOperator;
}