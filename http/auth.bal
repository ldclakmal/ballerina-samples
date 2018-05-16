// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.package http;

import ballerina/io;
import ballerina/http;
import ballerina/config;

function main(string... args) {
    io:println("Hello, Ballerina HTTP AUTH !");

    testNoAuth();
    testBasicAuth();
    testBearerTokenAuth();
    testOAuth();
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
        scheme: "basic",
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

endpoint http:Client bearerTokenAuthClient {
    url: config:getAsString("BEARER_TOKEN_AUTH_BASE_URL"),
    auth: {
        scheme: "oauth",
        accessToken: config:getAsString("BEARER_TOKEN_AUTH_ACCESS_TOKEN")
    }
};

public function testBearerTokenAuth() {
    string requestPath = config:getAsString("BEARER_TOKEN_AUTH_REQUEST_PATH");
    var response = bearerTokenAuthClient->post(requestPath);

    io:println("\n--- Bearer token auth ---------------------------------------------------------------------------");
    io:println(response);
}

//*********************************************************************************************************************

endpoint http:Client oauthClient {
    url: config:getAsString("OAUTH_BASE_URL"),
    auth: {
        scheme: "oauth",
        accessToken: config:getAsString("OAUTH_ACCESS_TOKEN"),
        clientId: config:getAsString("OAUTH_CLIENT_ID"),
        clientSecret: config:getAsString("OAUTH_CLIENT_SECRET"),
        refreshToken: config:getAsString("OAUTH_REFRESH_TOKEN"),
        refreshUrl: config:getAsString("OAUTH_REFRESH_URL")
    }
};

public function testOAuth() {
    http:Request req = new;
    string requestPath = config:getAsString("OAUTH_REQUEST_PATH");
    var response = oauthClient->get(requestPath, request = req);

    io:println("\n--- OAuth ---------------------------------------------------------------------------");
    io:println(response);
}
