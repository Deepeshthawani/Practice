public with sharing class MaxOppTriggerHandler {

    public static void after(List<Opportunity> oppList, Map<Id,Opportunity> oldMap){
        Set<Id> accountIds = new Set<Id>();

        if(!oppList.isEmpty()){
            for(Opportunity opp : oppList){
                if(!oldMap = null){
                    Opportunity oldOpp = oldMap.get(opp.id);

                if(oldOpp.AccountId != opp.AccountId){
                    accountIds.add(oldOpp.AccountId);
                    accountIds.add(opp.AccountId);
                }

                else{
                    accountIds.add(opp.AccountId);
                }
                }
                else{
                    accountIds.add(opp.AccountId);
                }
            }
        }

        if(!accountIds.isEmpty()){
            List<Account> accList = [Select maxOpp__c, (Select Name,Amount from Opportunities where Amount!=null order by Amount desc Limit 1)
                                    from Account where Id in :accountIds];
            List<Account> listToUpdate = new List<Account>();

            if(!accList.isEmpty()){
                for(Account acc : accList){
                    if(!acc.Opportunities.isEmpty()){
                        acc.maxOpp__c = acc.Opportunities[0].Name;
                        listToUpdate.add(acc);
                    }
                    else{
                        acc.maxOpp__c = '';
                        listToUpdate.add(acc);
                    }
                }
            }

            if(!listToUpdate.isEmpty()){
                update listToUpdate;
            }
        }
    }
}