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
// under the License.package connectors;

import ballerina/config;
import ballerina/http;
import ballerina/io;
import wso2/github4;

function main(string... args) {
    endpoint github4:Client githubClient {
        clientConfig: {
            auth: {
                scheme: http:OAUTH2,
                accessToken: config:getAsString("GITHUB_TOKEN")
            }
        }
    };

    github4:Repository repository = {};
    var repo = githubClient->getRepository("wso2-ballerina/package-github");
    match repo {
        github4:Repository rep => {
            repository = rep;
        }
        github4:GitClientError err => {
            io:println(err);
        }
    }

    io:println(repository);
}