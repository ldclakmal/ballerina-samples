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
// under the License.package sample;

import ballerina/config;

endpoint http:Client basicAuthClient {
    url:config:getAsString("BASIC_AUTH_BASE_URL"),
    auth:{
        scheme:"basic",
        username:config:getAsString("BASIC_AUTH_USERNAME"),
        password:config:getAsString("BASIC_AUTH_PASSWORD")
    }
};

public function testBasicAuth() {
    string requestPath = config:getAsString("BASIC_AUTH_REQUEST_PATH");
    var response = basicAuthClient -> get(requestPath);

    io:println("--- Basic auth :");
    io:println(response);
    io:println("---------------------------------------------------------------------------\n");
}