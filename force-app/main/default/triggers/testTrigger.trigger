//roll up no of contacts on an account

trigger testTrigger on Contact (after insert,after update, after delete, after undelete) {
    Set<Id> acc = new Set<Id>();
    If(Trigger.isInsert || Trigger.isUndelete){
        For(Contact con : trigger.new){
            acc.add(con.accountid);
        }
    }

    If(Trigger.isDelete){
        For(Contact c : trigger.old){
            acc.add(c.accountid);
        }
    }

    If(Trigger.isUpdate){
        For(Contact co : trigger.new){
            if(Trigger.oldMap.get(co.accountid)!= co.AccountId){
                acc.add(co.accountid);
            }
            acc.add(co.accountid);
        }
    }

    Map<Id,Account> accMap = new Map<Id,Account>();

    For(Account a : [Select id,countcon__c, (Select id from contacts) from Account where id in :acc]){
        accMap.put(a.id, a);
    }

    If(!accMap.isEmpty()){
        For(Contact c : Trigger.new){
            If(accMap.containsKey(c.accountid)){
                List<Contact> cList = accMap.get(c.accountid).contacts;
                accMap.get(c.accountid).countcon__c = cList.size();
            }
        }

        For(Contact c : Trigger.old){
            If(accMap.containsKey(c.accountid)){
                List<Contact> cList = accMap.get(c.accountid).contacts;
                accMap.get(c.accountid).countcon__c = cList.size();
            }
        }
    }

        List<Account> accListUpdated = new List<account>();
        accListUpdated.addAll(accMap.values());
        database.update(accListUpdated, false);
}

    
    




    //amount on opp get count of amt having grouped by name count of amt is > 100

    [Select name, COUNT(Amount) from Opportunity group by Name having COUNT(Amount) > 100 ];

    //opp - 5th highest amount
    [Select Amount from Opportunity LIMIT 5 order by desc];

    









}