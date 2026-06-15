public with sharing class MapsUtil {

    public static void understandRecordGrouping(){
        Map<Id, List<Contact>> accIdVsContactMap = new Map<Id, List<Contact>>();

        List<Contact> conList = [SELECT Id, FirstName, Email, LastName, AccountId FROM Contact WHERE AccountId != null];
        for(Contact con: conList){
            if(accIdVsContactMap.containsKey(con.AccountId)){
                List<Contact> conListToAppend = accIdVsContactMap.get(con.AccountId);
                conListToAppend.add(con);
                accIdVsContactMap.put(con.AccountId, conListToAppend);
            }
            else{
                accIdVsContactMap.put(con.AccountId, new List<Contact>{con});
            }
        }
        /*
        for(Id accId : accIdVsContactMap.keySet()){
            System.debug('Looping for: ' + accId + ' with values of contact: ' + accIdVsContactMap.get(accId));
        }*/

        Map<Id, Integer> accIdVsContactCountMap = new Map<Id, Integer>();
        for(Id accId : accIdVsContactMap.keySet()){
            accIdVsContactCountMap.put(accId, accIdVsContactMap.get(accId).size());
        }

        for(Id accId : accIdVsContactCountMap.keySet()){
            System.debug('Looping for: ' + accId + ' with size of contact: ' + accIdVsContactCountMap.get(accId));
        }

        for(Id accId : accIdVsContactCountMap.keySet()){
            if(accIdVsContactCountMap.get(accId) >= 2){
                System.debug('Looping for: ' + accId + ' with size of contact: ' + accIdVsContactCountMap.get(accId));
            }
        }

    }


    public static void handleBeforeUpdate(List<Opportunity> newRecords, List<Opportunity> oldRecords, Map<Id,Opportunity> newMap, Map<Id,Opportunity> oldMap){
       
        for(Opportunity opp: newRecords){
            String oldStage = oldMap.get(opp.Id).StageName;
            String newStage = newMap.get(opp.Id).StageName;

            if(oldStage != newStage){
                System.debug('Stage was changed');
                if(newStage == 'Value Proposition' && oldStage == 'Needs Analysis'){
                    System.debug('I want to create a task');
                }
            }

        }
    }
    
    public static void understandMapMethods(){
        Map<String,String> roleVsNameMap = new Map<String,String>();
        //need to add values to the map
        roleVsNameMap.put('Salesforce Engineer', 'Himanshu Maheshwari');
        roleVsNameMap.put('Salesforce Quality', 'Jayant Rajput');
        roleVsNameMap.put('Salesforce Quality', 'Arbaaz Khan');
        roleVsNameMap.put('Salesforce Product', 'Soniya');
        System.debug(roleVsNameMap);

        //Result of how it is stored: {Salesforce Engineer=Himanshu Maheshwari}
        //{Salesforce Engineer=Himanshu Maheshwari, Salesforce Product=Soniya, Salesforce Quality=Arbaaz Khan}

        //need to get data from a Map
        String productName = roleVsNameMap.get('Salesforce Product');
        System.debug('PO for the project is: ' + productName);

        //size of the map: tells you the number of key-value pairs
        Integer sizeOfMap = roleVsNameMap.size();
        System.debug('Total Roles in this project: ' + sizeOfMap);

        //if I want to check if a specific key exists or not
        Boolean qualityFound = roleVsNameMap.containsKey('Salesforce Quality');
        System.debug('Quality Engineer is part of project? ' + qualityFound);

        //if I want to check if a specific value exists or not: 
        //Is Jayant Part of the project or not?
        if(roleVsNameMap.containsKey('Salesforce Quality')){
            String qualityEngineerValue = roleVsNameMap.get('Salesforce Quality'); //returns a value -> Jayant Rajput in our case
            if(qualityEngineerValue == 'Jayant Rajput'){
                System.debug('Jayant R is part of the project');
            }
        }

        //how to fetch all the values of a map
        List<String> myMembers = roleVsNameMap.values();
        System.debug('Members of the project are: ' + myMembers);
        // how to fetch all keys of the map:
        Set<String> allRoles = roleVsNameMap.keyset();
        System.debug('Roles of the project are: ' + allRoles);

        //to copy the entire map into another map variable
        Map<String,String> roleVsNameMapPrivate = roleVsNameMap.clone();

        //clear up the map & empty it
        roleVsNameMap.clear();

        //if you need to check if map has any data or not
        Boolean isMapEmpty = roleVsNameMap.isEmpty();
        System.debug('Map is empty? ' + isMapEmpty);

        Boolean isPrivateMapEmpty = roleVsNameMapPrivate.isEmpty();
        System.debug('Private Map is empty? ' + isPrivateMapEmpty);

        //how to remove a key from a map
        System.debug('Before key removal: ' + roleVsNameMapPrivate);
        roleVsNameMapPrivate.remove('Salesforce Quality');
        System.debug('After key removal: ' + roleVsNameMapPrivate);

        //re enable member to the project by using put
        roleVsNameMapPrivate.put('Salesforce Quality', 'Jayant Rajput');
        System.debug('Final Team: ' + roleVsNameMapPrivate);}

    public static Map<String, List<Opportunity>> populateMapUnderstanding(){
        Map<String, List<Opportunity>> stageBasedOppMap = new Map<String, List<Opportunity>>();
        
        List<Opportunity> oppRecords = [SELECT Id, Name, StageName FROM Opportunity LIMIT 10];

        for(Opportunity opp: oppRecords){
            System.debug('Entered for: ' + opp);
            if(stageBasedOppMap.containsKey(opp.StageName)){
                System.debug('Entered for: ' + opp.StageName + ' after the first time');
                List<Opportunity> currentOppList = stageBasedOppMap.get(opp.StageName);
                currentOppList.add(opp);
                stageBasedOppMap.put(opp.StageName, currentOppList);
            }
            else{
                System.debug('Entered for: ' + opp.StageName + ' for the first time');
                stageBasedOppMap.put(opp.StageName, new List<Opportunity>{opp});
            }
        }
        return stageBasedOppMap;
    
    }

    public static void understandMapDeclarations(){
        
        //Basic declaration with no values
        Map<String,String> mapWithoutDefaultValues = new Map<String, String>();
        mapWithoutDefaultValues.put('1', 'Himanshu');
        mapWithoutDefaultValues.put('2', 'Maheshwari');
        System.debug(mapWithoutDefaultValues);

        //Basic declaration with default values
        Map<String,String> mapWithDefaultValues = new Map<String,String>{
            '1' => 'Srini',
            '2' => 'Victor',
            '3' => 'Naitik'
        };

        System.debug(mapWithDefaultValues);

        //Declaration with SOQL query
        Map<Id, Opportunity> oppRecordsMap = new Map<Id, Opportunity>([SELECT Id, Name, StageName FROM Opportunity]);
        System.debug(oppRecordsMap);

        //loop through keys
        for(Id oppId: oppRecordsMap.keyset()){
            System.debug(oppId);
        }


        //loop through all the values
        for(Opportunity opp: oppRecordsMap.values()){
            System.debug(opp.StageName);
        }

        //find the record which has Stagename = Prospecting and Name is Finding this out
        for(Opportunity opp: oppRecordsMap.values()){
            if(opp.StageName == 'Prospecting' && opp.Name == 'Finding this out'){
                System.debug(opp.Id);
            }
        }

        for(Id oppId: oppRecordsMap.keyset()){
            Opportunity oppRecordInHand = oppRecordsMap.get(oppId);
            if(oppRecordInHand.StageName == 'Prospecting' && oppRecordInHand.Name == 'Finding this out'){
                System.debug(oppId);
            }
        }

    }

    public static void handleListViaMap(List<Opportunity> oppRecords){

        Map<Id,Opportunity> oppRecordsMap = new Map<Id,Opportunity>(oppRecords);
        System.debug(oppRecordsMap);
        //use the map directly in your code further
    }

    public static void handleHighValueOpportunities(){
        List<Account> accountList = [SELECT Id, Name FROM Account LIMIT 200];
        List<Opportunity> opportunityList = [SELECT Id, AccountId, StageName, Amount FROM Opportunity WHERE isClosed = false AND AccountId IN :accountList];
        List<Contact> contactList = [SELECT Id, Email, FirstName, LastName, AccountId FROM Contact WHERE AccountId IN :accountList];
        
        System.debug(accountList.size());
        System.debug(opportunityList.size());
        System.debug(contactList.size());

        //iterate over every account I have
        //inside I would iterate over every oppportunity I have for each account
        //for every opp, I would checkif it has amount > 10L and isclosed = false
        //if yes: I would set up boolean flag - that this account has a high value opp
        //if I found atleast one high value opp, I would check all contacts in my account - that particualr account for which I found oneopp
        //for every such contact I found for that account, I would create task record and insert the taskList

        Map<Id,Boolean> accountIdWithHighValueOppFound = new Map<Id,Boolean>();
        Map<Id,List<Contact>> accountIdToContactsMap = new Map<Id,List<Contact>>();
        
        for(Opportunity opp: opportunityList){
            if(opp.AccountId != null && opp.Amount >= 1000000)
            //high value opp
            accountIdWithHighValueOppFound.put(opp.AccountId, true);
        }

        for(Contact con: contactList){
            //the below should onlybe done if account qualifies as a high value
            if(accountIdWithHighValueOppFound.containsKey(con.AccountId)){
                if(accountIdToContactsMap.containsKey(con.AccountId)){
                    List<Contact> conListToAppend = accountIdToContactsMap.get(con.AccountId);
                    conListToAppend.add(con);
                    accountIdToContactsMap.put(con.AccountId, conListToAppend);
                }
                else{
                    accountIdToContactsMap.put(con.AccountId, new List<Contact>{con});
                }
            }
        }
        List<Contact> conListToCreateTasksFor =new List<Contact>();
        for(List<Contact> conList: accountIdToContactsMap.values()){
            conListToCreateTasksFor.addAll(conList);
        }
        List<Task> tList = new List<Task>();
        for(Contact con: conListToCreateTasksFor){
            Task t =  new Task();
            t.WhoId = con.Id;
            t.WhatId = con.AccountId;
            tList.add(t);
        }

        insert tList;
    }

    public static void handleSOQLWithinLoop(){
        //for every account where Indystry is Technology
        //find all contacts and create Tasks for them
        List<Contact> conList = [SELECT Id, AccountId, FirstName, LastName, Email FROM Contact WHERE AccountId != null];
        List<Id> accIds = new List<Id>();

        for(Contact con: conList){
            accIds.add(con.AccountId);
        }
        Map<Id,Account> accountMap = new Map<Id,Account>([SELECT Id, Name, Industry FROM Account WHERE Id IN :accIds]);
        List<Task> tList = new List<Task>();
        for(Contact con: conList){
             Id accId = con.AccountId;
             if(accId != null){
                Account acc = accountMap.get(accId);
                if(acc != null){
                    Task tRec = new Task();
                    tRec.WhatId = accId;
                    tRec.WhoId = con.Id;
                    tList.add(tRec);
                }
            }
        }

        if(!tList.isEmpty()){
            insert tList;
        }

        for(Contact con: conList){
            //overworks for too many records
            Id accId = con.AccountId;
            Account acc = [SELECT Id, Industry FROM Account WHERE Id = :accId LIMIT 1]; //-> number of SOQL queries exception
            if(acc.Industry == 'Technology'){
                //create task record here
            }
        }
    }

    
}