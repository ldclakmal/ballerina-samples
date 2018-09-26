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
import ballerina/log;

endpoint http:Client clientEP {
    url: "http://dummy.restapiexample.com/api/v1"
};

public function main(string... args) {
    var resp = clientEP->get("/employee/1");

    match resp {
        http:Response response => {
            match (response.getTextPayload()) {
                string res => io:println("--- GET Response : " + res);
                error err => log:printError(err.message);
            }
        }
        error err => log:printError(err.message);
    }

    http:Request req;
    req.setJsonPayload(
           {
               "name": "sample",
               "salary": "100",
               "age": 20
           }
    );
    var respPost = clientEP->post("/create", req);

    match respPost {
        http:Response response => {
            match (response.getTextPayload()) {
                string res => io:println("--- POST Response : " + res);
                error err => log:printError(err.message);
            }
        }
        error err => log:printError(err.message);
    }
}
