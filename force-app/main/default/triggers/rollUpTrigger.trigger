//display no of contacts on account

trigger rollUpTrigger on Contact (after insert, after update, after delete, after undelete) {
    Set<Id> ac = new Set<Id>();

    If(Trigger.isInsert || Trigger.isUndelete){
        For(Contact con : Trigger.new){
            ac.add(con.AccountId);
        }
    }

    If(Trigger.isDelete){
        For(Contact con : Trigger.old){
            ac.add(con.AccountId);
        }
    }

    If(Trigger.isUpdate){
        For(Contact con : Trigger.new){
            If(con.AccountId != Trigger.oldMap.get(con.id).AccountId){
                ac.add(con.AccountId);
            }
            ac.add(con.AccountId);
        }
    }

    Map<Id,Account> acMap = new Map<Id,Account>();

    If(!ac.isEmpty()){
        For(Account a : [Select id,No_Of_Con__c, (Select id from Contacts) from Account where id in :ac]){
            acMap.put(a.id, a);
        }
    }

    For(Contact c : Trigger.new){
        If(acMap.containsKey(c.AccountId)){
            List<Contact> conList = new List<Contact>();
            conList = acMap.get(c.AccountId).contacts;
            acMap.get(c.AccountId).No_Of_Con__c = conList.size();
        }
    }


}