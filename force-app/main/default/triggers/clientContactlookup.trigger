//Create a field on Account Named (Client Contact lookup to Contact). Once an Account is inserted a Contact will create with the name 
//of the Account and that Contact will be the Client Contact on the Account.

trigger clientContactlookup on Account (after insert) {
    Set<Id> ac = new Set<Id>();
    List<Contact> clist = new List<Contact>();
    For(Account a: Trigger.new){
        Contact c = new Contact();
        c.LastName = a.Name;
        c.AccountId = a.id;
        clist.add(c);
        ac.add(a.id);
    }

    if(!clist.isEmpty()){
        insert clist;
    }

    List<Account> aclist = [Select id,client_contact__c from account where id in :ac];
    Map<Id,Account> accMap = new Map<Id,Account>();
    List<Account> lstAcc = new List<Account>();

    If(!aclist.isEmpty()){
        For(Account acc : aclist){
            accMap.put(acc.id, acc);
        }
    }

    if(!clist.isEmpty()){
        For(Contact co : clist){
            If(accMap.containsKey(co.AccountId)){
                accMap.get(co.AccountId).client_contact__c = co.id;
            }
        }
        lstAcc.add(accMap.values());
    }

    If(!lstAcc.isEmpty()){
        update lstAcc;
    }

}