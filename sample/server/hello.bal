import ballerina/http;

service /foo on new http:Listener(9090) {
    resource function get bar() returns string {
        return "Hello, World!";
    }
}
