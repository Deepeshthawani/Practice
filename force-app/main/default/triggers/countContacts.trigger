trigger countContacts on Contact (after insert,after update, after delete, after undelete) {
    Set<Id> accountIds = new Set<Id>();

    If(Trigger.isInsert || Trigger.isUndelete){
        For(Contact c : Trigger.new){
            accountIds.add(c.AccountId);
        }
    }

    If(Trigger.isUpdate){
        For(Contact c : Trigger.new){
            If(c.AccountId != Trigger.oldMap.get(c.Id).AccountId){
                accountIds.add(Trigger.oldMap.get(c.Id).AccountId);
            }
            accountIds.add(c.AccountId);
        }
    }

    If(Trigger.isDelete){
        For(Contact c : Trigger.old){
            accountIds.add(c.AccountId);
        }
    }


    List<Account> accountsToUpdate = new List<Account>();
    List<Account> accList = [Select id, noOfContacts__c, name,(Select id from Contacts) from Account where id in :accountIds];

    If(!accList.isEmpty()){
        For(Account a : accList){
            a.noOfContacts__c = a.contacts.size();
            accountsToUpdate.add(a);
        }
    }

    If(!accountsToUpdate.isEmpty()){
        Update accountsToUpdate;
    }
}