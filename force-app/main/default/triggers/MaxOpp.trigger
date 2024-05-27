//Business Use Case: A Sales Organization wants to track the largest Opportunity associated with each of its Accounts. 
//This information could be used to prioritize sales efforts, allocate resources, or identify opportunities for cross-selling 
//or upselling.

trigger MaxOpp on Opportunity (after insert, after update, after delete, after undelete) {

if(Trigger.isAfter && Trigger.isUpdate){
    MaxOppTriggerHandler.after(Trigger.new,Trigger.oldMap);
}

if(Trigger.isAfter && Trigger.isDelete){
    MaxOppTriggerHandler.after(Trigger.old,null);
}

else{
    MaxOppTriggerHandler.after(Trigger.new,null);
}

}