trigger TotalOppAmount on Account (before update) {
    Set<Id> ac = new Set<Id>();

    For(Account acc: Trigger.new){
        ac.add(acc.id);
    }

    Map<Id, Double> totalOppAmount = new Map<Id, Double>();

    List<Aggregate> ag = [Select AccountId, Sum(Amount)Totalamount from Opportunity where AccountId in :acid group by AccountId];

    if (!ag.isEmpty()) {
        For(AggregateResult a: ag){
            Id accountid = (Id)a.get('AccountId');
            Double TotalAmount = (Double)a.get('Totalamount');
            totalOppAmount.put(accountid,TotalAmount);
        }
    }

    For(Account ac:Trigger.new){
        If(totalOppAmount.containskey(ac.id)){
            ac.Total_Opportunity_Amount__c = totalOppAmount.get(ac.id);
        }
    }
}
    
