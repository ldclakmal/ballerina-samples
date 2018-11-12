import ballerina/io;
import ballerina/http;
import ballerina/config;
import ballerina/runtime;

public function main(string... args) {
    io:println("Hello, Ballerina HTTP AUTH !");

    testNoAuth();
    testBasicAuth();
    testOAuth2();
    testJWTAuth();
}

//*********************************************************************************************************************

endpoint http:Client noAuthClient {
    url: config:getAsString("NO_AUTH_BASE_URL")
};

public function testNoAuth() {
    string requestPath = config:getAsString("NO_AUTH_REQUEST_PATH");
    var response = noAuthClient->get(requestPath);

    io:println("\n--- No auth ---------------------------------------------------------------------------");
    io:println(response);
}

//*********************************************************************************************************************

endpoint http:Client basicAuthClient {
    url: config:getAsString("BASIC_AUTH_BASE_URL"),
    auth: {
        scheme: http:BASIC_AUTH,
        username: config:getAsString("BASIC_AUTH_USERNAME"),
        password: config:getAsString("BASIC_AUTH_PASSWORD")
    }
};

public function testBasicAuth() {
    string requestPath = config:getAsString("BASIC_AUTH_REQUEST_PATH");
    var response = basicAuthClient->get(requestPath);

    io:println("\n--- Basic auth ---------------------------------------------------------------------------");
    io:println(response);
}

//*********************************************************************************************************************

endpoint http:Client oauth2Client {
    url: config:getAsString("OAUTH2_BASE_URL"),
    auth: {
        scheme: http:OAUTH2,
        accessToken: config:getAsString("OAUTH2_ACCESS_TOKEN"),
        clientId: config:getAsString("OAUTH2_CLIENT_ID"),
        clientSecret: config:getAsString("OAUTH2_CLIENT_SECRET"),
        refreshToken: config:getAsString("OAUTH2_REFRESH_TOKEN"),
        refreshUrl: config:getAsString("OAUTH2_REFRESH_URL")
    }
};

public function testOAuth2() {
    string requestPath = config:getAsString("OAUTH2_REQUEST_PATH");
    var response = oauth2Client->get(requestPath);

    io:println("\n--- OAuth2 ---------------------------------------------------------------------------");
    io:println(response);
}

//*********************************************************************************************************************

endpoint http:Client jwtClient {
    url: config:getAsString("JWT_BASE_URL"),
    auth: {
        scheme: http:JWT_AUTH
    }
};

public function testJWTAuth() {
    string token = config:getAsString("JWT_TOKEN");
    runtime:getInvocationContext().authContext.scheme = "jwt";
    runtime:getInvocationContext().authContext.authToken = token;
    string requestPath = config:getAsString("JWT_REQUEST_PATH");
    var response = jwtClient->get(requestPath);

    io:println("\n--- JWT ---------------------------------------------------------------------------");
    io:println(response);
}
