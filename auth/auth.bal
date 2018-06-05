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
    testOAuth2();
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
