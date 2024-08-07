//acc record insert field on user obj - userDetail -  update name of the createduser & phoneno on the acc

trigger testTriggerrun on Account (after insert) {
Set<Id> ac = new Set<Id>();

    For(Account a : Trigger.new){
        ac.add(a.id);
    }
    List<User> ulist = new List<User>();

    List<Account> acc = [Select id,createdby.name, phone from Account where id in :ac];
    If(!acc.isEmpty()){
        For(Account ac : acc){
            User u = new User();
            u.id = ac.CreatedBy;
            u.userDetail = 'Name of the user - ' +ac.CreatedBy.name + 'Phone -' + ac.Phone;
            ulist.add(u);
        }
    }

    UpdateUser.futuremetod(ulist);
    
    // If(!ulist.isEmpty()){
    //     update ulist;
    // }

}