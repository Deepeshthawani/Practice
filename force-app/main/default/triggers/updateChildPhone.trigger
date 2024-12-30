trigger updateChildPhone on Account (after insert,after update) {
    Map<Id,Account> accMap = new Map<Id,Account>();
    For(Account a : Trigger.new){
        if(a.Phone!=null && a.Phone != trigger.oldMap.get(a.id).Phone){
            accMap.put(a.Id,a);
        }

        
    }
    List<Contact> conList = [Select Id, Name, Phone from Contact where AccountId in :accMap.keySet()];
    List<Contact> coList = new List<Contact>();
    if(!conList.isEmpty()){
        For(Contact con : conList){
            con.Phone=accMap.get(con.AccountId).Phone;
            coList.add(con);
        }
    }

    if(!coList.isEmpty()){
        update coList;
    }

}