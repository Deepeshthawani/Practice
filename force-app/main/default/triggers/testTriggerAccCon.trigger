trigger testTriggerAccCon on Contact (after insert,after update, after delete, after undelete) {

    Set<Id> accId = new Set<Id>();
    If(Trigger.isInsert || Trigger.isUndelete){
        For(Contact con : Trigger.new){
            if(con.AccountId != null){
                accId.add(con.AccountId);
            }
        }
    }

    If(Trigger.isUpdate){

        For(Contact con : Trigger.new){
            if(con.AccountId != Trigger.oldMap.get(con.id).AccountId){
                accId.add(con.AccountId);
            }
            accId.add(con.AccountId);
        }
    }

    If(Trigger.isDelete){
        For(Contact con : Trigger.old){
            if(con.AccountId != null){
                accId.add(con.AccountId);
            }
        }
    }

    Map<Id,Account> accMap = new Map<Id,Account>();

    List<Account> lstacc = [Select id, no_of_contacts__c, (select id from Contacts) from Account where id in :accId];
    if(!lstacc.isEmpty()){
       For(Account a : lstacc){
        accMap.put(a.id, a);
       }
    }

    List<Account> accListToUpdate = new List<Account>();
    For(Contact c : Trigger.new){
        If(accMap.containsKey(c.AccountId)){
            List<Contact> conlist = new List<Contact>();
            conlist = accMap.get(c.AccountId).Contacts;
            accMap.get(c.AccountId).no_of_contacts__c = conlist.size();
            accListToUpdate.add(accMap.get(c.AccountId));
        }
    }


    If(!accListToUpdate.isEmpty()){
        update accListToUpdate;
    }

}