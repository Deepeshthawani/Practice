trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    Set<Id> accountIds = new Set<Id>();

    If(Trigger.isInsert || Trigger.isUndelete){
        for(Contact con: Trigger.new){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }
    }

    If(Trigger.isUpdate){
        
        for(Contact con: Trigger.new){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }

        for(Contact oldCon: Trigger.old){
            If(oldCon.AccountId!=null && !accountIds.contains(oldCon.AccountId)){
                accountIds.add(oldCon.AccountId);
            }
        }
    }

    If(Trigger.isDelete){
        for(Contact con: Trigger.old){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }
    }

    If(!accountIds.isEmpty()){
        List<Account> accountsToUpdate = new List<Account>();
        for(Id accountId : accountIds ){
            Integer contactCount = [Select COUNT() from Contact where AccountId =:accountId];
            Account acc = new Account(Id = accountId, No_Of_Contacts__c = contactCount);
            accountsToUpdate.add(acc);
        }

    If(!accountsToUpdate.isEmpty()){
        try{
            update accountsToUpdate;
        }
        
        catch (Exception e) {
                System.debug('Error updating accounts: ' + e.getMessage());
            }
    }
        
    }
}