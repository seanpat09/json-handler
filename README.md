# JSON Node

Handling JSON strings with arbitrary structures can be very difficult with a lot of serializing and deserializing. This library is attempts to make it easier to traverse a JSON object to retrieve whatever data you need.

## Usage

Given the following JSON string, to access the `FirstName` property of the third item in the `ContactList` property, you would have to do the following:
```
{ 
  "Account":{ 
    "ID" : "00100000000000000Y", 
    "Name" : "Test Name", 
    "ParentAccount":{ 
      "ID" : "00100000000000000X", 
      "Name" : "Test Parent Name" 
    }, 
    "ItemList" : [], 
    "ContactList" : [ { 
        "ID" : "00300000000000000Y", 
        "FirstName" : "Joey", 
        "LastName" : "Jojo" 
      }, { 
        "ID" : "00300000000000000Z", 
        "FirstName" : "Xandar", 
        "LastName" : "Ahmed" 
      }, { 
        "ID" : "00300000000000000X", 
        "FirstName" : "Melissa", 
        "LastName" : "Bond" 
      }, { 
        "ID" : "00300000000000000W", 
        "FirstName" : "Gina", 
        "LastName" : "Pavlova" 
      }] 
  }
}
```

```
Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(TEST_JSON);
Map<String, Object> accountMap = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(jsonMap.get('Account')));
List<Object> contactList = (List<Object>) JSON.deserializeUntyped(JSON.serialize(accountMap.get('ContactList')));
Map<String, Object> aContact = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(contactList[2]));
System.assertEquals('Melissa', (String)aContact.get('FirstName'));
```

With JSON Node, you can do the following instead:
```
System.assertEquals(
    'Melissa',
    (String) new JSONNode(TEST_JSON)
        .getNode('Account')
        .getNodeList('ContactList')[2]
    .getNodeValue('FirstName')
)
```