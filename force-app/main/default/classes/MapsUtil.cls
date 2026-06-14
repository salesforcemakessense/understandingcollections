public with sharing class MapsUtil {
    
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
}