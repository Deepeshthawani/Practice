trigger updateDescConToAcc on Contact (after update) {
    Set<Id> accId = new Set<Id>();
    Map<Id,String> accMap = new Map<Id,String>();
    For(Contact c: Trigger.new){
        If(c.Description !=null && c.Description != trigger.oldMap.get(c.id).Description){
            accId.add(c.AccountId);
            accMap.put(c.AccountId,c.Description);
        }
    }
    List<Account> accToUpdate = new List<Account>();
    For(Contact c:Trigger.new){
        If(accMap.containsKey(c.AccountId)){
            Account a = new Account();
            a.Id = c.AccountId;
            a.Description = accMap.get(c.AccountId); 
            accToUpdate.add(a);
        }
    }

    If(!accToUpdate.isEmpty()){
        update accToUpdate;
    }


}