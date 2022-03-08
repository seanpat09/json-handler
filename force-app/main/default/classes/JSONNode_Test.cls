@isTest
private with sharing class JSONNode_Test {
	private static final String TEST_JSON =
		'{' +
		'   "Account":{' +
		'     "ID" : "00100000000000000Y",' +
		'     "Name" : "Test Name",' +
		'     "ParentAccount":{' +
		'       "ID" : "00100000000000000X",' +
		'       "Name" : "Test Parent Name"' +
		'     },' +
		'     "ItemList" : [],' +
		'     "ContactList" : [ {' +
		'         "ID" : "00300000000000000Y",' +
		'         "FirstName" : "Joey",' +
		'         "LastName" : "Jojo"' +
		'       }, {' +
		'         "ID" : "00300000000000000Z",' +
		'         "FirstName" : "Xandar",' +
		'         "LastName" : "Ahmed"' +
		'       }, {' +
		'         "ID" : "00300000000000000X",' +
		'         "FirstName" : "Melissa",' +
		'         "LastName" : "Bond"' +
		'       }, {' +
		'         "ID" : "00300000000000000W",' +
		'         "FirstName" : "Gina",' +
		'         "LastName" : "Pavlova"' +
		'       }]' +
		'   }' +
		'}';

	@isTest
	private static void parseJSON() {
		System.assertEquals(
			'00100000000000000Y',
			(String) new JSONNode(TEST_JSON)
				.getNode('Account')
				.getNodeValue('ID')
		);
		System.assertEquals(
			'Test Name',
			(String) new JSONNode(TEST_JSON)
				.getNode('Account')
				.getNodeValue('Name')
		);

		System.assertEquals(
			'00100000000000000X',
			(String) new JSONNode(TEST_JSON)
				.getNode('Account')
				.getNode('ParentAccount')
				.getNodeValue('ID')
		);
		System.assertEquals(
			'Test Parent Name',
			(String) new JSONNode(TEST_JSON)
				.getNode('Account')
				.getNode('ParentAccount')
				.getNodeValue('Name')
		);

		System.assertEquals(
			'Joey',
			(String) new JSONNode(TEST_JSON)
					.getNode('Account')
					.getNodeList('ContactList')[0]
				.getNodeValue('FirstName')
		);
		System.assertEquals(
			'Xandar',
			(String) new JSONNode(TEST_JSON)
					.getNode('Account')
					.getNodeList('ContactList')[1]
				.getNodeValue('FirstName')
		);
		System.assertEquals(
			'Melissa',
			(String) new JSONNode(TEST_JSON)
					.getNode('Account')
					.getNodeList('ContactList')[2]
				.getNodeValue('FirstName')
		);
		System.assertEquals(
			'Gina',
			(String) new JSONNode(TEST_JSON)
					.getNode('Account')
					.getNodeList('ContactList')[3]
				.getNodeValue('FirstName')
		);

		List<Object> emptyList = new JSONNode(TEST_JSON)
			.getNode('Account')
			.getNodeList('ItemList');
		System.assert(emptyList.isEmpty());

		System.assertEquals(null, new JSONNode(TEST_JSON).getNode('randomKey'));
	}
}
