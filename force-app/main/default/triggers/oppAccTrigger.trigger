//Add a field Multi-select Picklist on Account and Opportunity as well and add values A,B,C,D,F. 
//Now if we update an Opportunity with this multi-select value Account should also update with the same picklist values.


trigger oppAccTrigger on Opportunity (after update) {
    Set<Id> ac = new Set<Id>();
    Map<Id,String> acUpdate = new Map<Id,String>(); 
    For(Opportunity op : Trigger.new){
        If(op.abcdf__c != Trigger.oldMap.get(op.id).abcdf__c){
            ac.add(op.AccountId);
            acUpdate.put(op.AccountId, op.abcdf__c);
        }
    }

    List<Account> acList = [Select id,abcdf__c from Account where id in :ac];
    List<Account> acToUpdate = new List<Account>();
    If(!acList.isEmpty()){
        for (Account a : acList) {
            If(acUpdate.containsKey(a.id)){
                a.abcdf__c = acUpdate.get(a.id);
                acToUpdate.add(a);
            }
        }
    If(!acToUpdate.isEmpty()){
        update acToUpdate;
    }
    }
}