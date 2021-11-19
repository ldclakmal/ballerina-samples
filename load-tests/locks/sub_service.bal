import ballerina/http;
import ballerina/log;

isolated service /foo on new http:Listener(9445) {

    isolated resource function post bar(@http:Payload json payload) returns json {
        log:printInfo("Invoked foo/bar endpoint...");
        return payload;
    }
}
