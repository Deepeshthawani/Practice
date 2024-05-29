/*Once an Account will update then that Account will update with the total amount from All its Opportunities on the 
Account Level. The account field name would be ” Total Opportunity Amount “*/

trigger oppAmountTrigger on Account (before update) {
    Set<Id> accSet = new Set<Id>();
    for(Account a: Trigger.new){
        a.Total_Opportunity_Amount__c=0;
        accSet.add(a.Id);
        
    }

    if(!accSet.isEmpty()){
        Map<Id,Double> amt = new Map<Id,Double>();
        List<AggregateResult> agg = [Select AccountId, Sum(Amount)opAmount from Opportunity where AccountId in :accSet group by AccountId];
        if(!agg.isEmpty()){
            for(AggregateResult aggr : agg){
            Id accountId = (Id)aggr.get('AccountId');
            Double TotalAmount = (Double)aggr.get('opAmount');
            amt.put(accountId, TotalAmount);
        }
    }
    for(Account acc:Trigger.new){
        if(amt.containsKey(acc.id)){
            acc.Total_Opportunity_Amount__c = amt.get(acc.id);
        }
    }
    }
}