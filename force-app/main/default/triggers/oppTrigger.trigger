//If stage is updated, then in the parent account record description field should be updated with previous and new value of opp stage

trigger oppTrigger on Opportunity (after update) {
    Set<Id> ac = new Set<Id>();
    For(Opportunity o : Trigger.new){
        If(Trigger.oldmap.get(o.id).StageName != o.StageName){
            ac.add(o.AccountId);
        }
    }

    List<Account> aclist = [Select id,Description from Account where id in :ac];
    Map<Id,Account> accMap = new Map<Id,Account>();
    List<Account> lstUpdate = new List<Account>();
    If(!aclist.isEmpty()){
        For(Account a : aclist){
            accMap.put(a.id, a);
        }
    }

    If(!accMap.isEmpty()){
        For(Opportunity op:Trigger.new){
            If(accMap.containsKey(op.AccountId)){
                accMap.get(op.AccountId).Description = 'Old StageName -' + Trigger.oldmap.get(op.id).StageName + ' New StageName -' + op.StageName;
                lstUpdate.add(accMap.values());
            }
        }
    }

    If(!lstUpdate.isEmpty()){
        update lstUpdate;
    }




}