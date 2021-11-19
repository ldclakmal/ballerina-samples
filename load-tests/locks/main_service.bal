import ballerina/http;

isolated map<json> payloadMap = {};

final http:Client ep = check new("http://localhost:9445");

isolated service /foo on new http:Listener(9090) {
    isolated resource function post .(@http:Payload json payload) returns json|error {
        lock {
            string key = "foo";
            if (payloadMap.hasKey(key)) {
                return payloadMap.get(key).cloneReadOnly();
            } else {
                json message = check ep->post("/foo/bar", payload.cloneReadOnly());
                payloadMap[key] = message;
                return message.cloneReadOnly();
            }
        }
    }
}
