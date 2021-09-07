import ballerina/http;
import ballerina/jwt;
import ballerina/regex;

const string AUTHZ_SIGNATURE_COOKIE_NAME = "cwatf";

final http:ListenerJwtAuthHandler jwtAuthHandler = new ({
    issuer: "wso2",
    audience: "ballerina",
    signatureConfig: {
        certFile: "./resources/public.crt"
    }
});

public isolated function authenticateUser(string authHeader, string cookieHeader) returns jwt:Payload|http:Unauthorized|error {
    string header = check buildCompleteHeader(authHeader, cookieHeader);
    return jwtAuthHandler.authenticate(header);
}

isolated function buildCompleteHeader(string authHeader, string cookieHeader) returns string|error {
    return authHeader + "." + check extractCookieValue(cookieHeader);
}

isolated function extractCookieValue(string cookie) returns string|error {
    string[] cookieFragments = regex:split(cookie, AUTHZ_SIGNATURE_COOKIE_NAME + "=");
    if cookieFragments.length() == 2 {
        return cookieFragments[1];
    }
    return error(AUTHZ_SIGNATURE_COOKIE_NAME + " cookie is not available.");
}
