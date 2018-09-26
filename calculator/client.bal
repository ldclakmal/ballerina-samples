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
// under the License.package calculator;

import ballerina/http;
import ballerina/io;
import ballerina/log;

endpoint http:Client clientEndpoint {
    url: "http://localhost:9090"
};

public function main(string... args) {

    http:Request req = new;

    // Set the JSON payload to the message to be sent to the endpoint.
    json jsonMsg = { firstNumber: 15.6, secondNumber: 18.9, operation: "add" };
    req.setJsonPayload(jsonMsg);

    var response = clientEndpoint->post("/calculator/operation", req);
    match response {
        http:Response resp => {
            var msg = resp.getJsonPayload();
            match msg {
                json jsonPayload => {
                    string resultMessage = "Addition result " + jsonMsg["firstNumber"].toString() +
                        " + " + jsonMsg["secondNumber"].toString() + " : " +
                        jsonPayload["result"].toString();
                    io:println(resultMessage);
                }
                error err => {
                    log:printError(err.message, err = err);
                }
            }
        }
        error err => {
            log:printError(err.message, err = err);
        }
    }
}