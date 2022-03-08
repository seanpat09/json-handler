public with sharing class JSONNode {
	Map<String, Object> parsedJSON;
	public JSONNode(String jsonString) {
		this.parsedJSON = (Map<String, Object>) JSON.deserializeUntyped(
			jsonString
		);
	}

	public JSONNode getNode(String nodeKey) {
		if (this.parsedJSON.get(nodeKey) != null) {
			return new JSONNode(JSON.serialize(this.parsedJSON.get(nodeKey)));
		}
		return null;
	}

	public Object getNodeValue(String nodeKey) {
		return this.parsedJSON.get(nodeKey);
	}

	public List<JSONNode> getNodeList(String nodeKey) {
		if (this.parsedJSON.get(nodeKey) != null) {
			List<JSONNode> nodeList = new List<JSONNode>();
			List<Object> objects = (List<Object>) JSON.deserializeUntyped(
				JSON.serialize(this.parsedJSON.get(nodeKey))
			);
			for (Object o : objects) {
				nodeList.add(new JSONNode(JSON.serialize(o)));
			}
			return nodeList;
		}
		return null;
	}
}
