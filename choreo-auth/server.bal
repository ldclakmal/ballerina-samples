import ballerina/http;
import ballerina/jwt;

service /foo on new http:Listener(9090) {
    resource function get bar(@http:Header {name: "Authorization"} string authHeader, @http:Header {name: "Cookie"} string cookieHeader) returns string|http:Unauthorized|error {
        jwt:Payload|http:Unauthorized result = check authenticateUser(authHeader, cookieHeader);
        if result is http:Unauthorized {
            return result;
        }
        return "Hello, World!";
    }
}
