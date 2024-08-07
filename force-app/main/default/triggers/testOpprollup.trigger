trigger testOpprollup on Account (before update) {
    Set<Id> ac = new Set<Id>();
    For(Account a : Trigger.new){
        ac.Total_Opportunity__c = 0;
        ac.add(a.Id);
    }
    Map<Id,Double> accMap = new Map<Id,Double>();
    List<AggregrateResult> ar = [Select Id, AccountId, Sum(Amount)TotalAmount from Opportunity where AccountId in :ac group by AccountId];

    If(!ar.isEmpty()){
        For(AggregrateResult a : results){
            Id accountId = (Id)a.get('AccountId');
            Double TotalAmount = (Double)a.get('TotalAmount');
            accMap.put(accountId,TotalAmount);
        }
    }

    For(Account ac: Trigger.new){
        if(accMap.containsKey(ac.id)){
            ac.Total_Opp__c = accMap.get(ac.id);
        }
    }
}