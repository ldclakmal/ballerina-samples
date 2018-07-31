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

endpoint http:Listener listener {
    port: 9090
};

// Calculator REST service
@http:ServiceConfig { basePath: "/calculator" }
service<http:Service> Calculator bind listener {

    // Resource that handles the HTTP POST requests that are directed to
    // the path `/operation` to execute a given calculate operation
    // Sample requests for add operation in JSON format
    // `{ "firstNumber": 10, "secondNumber":  200, "operation": "add"}`
    // `{ "firstNumber": 10, "secondNumber":  20.0, "operation": "+"}`

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/operation"
    }
    executeOperation(endpoint client, http:Request req) {
        json operationReq = check req.getJsonPayload();
        string operation = operationReq.operation.toString();

        any result = 0.0;
        // Pick first number for the calculate operation from the JSON request
        float firstNumber = 0;
        var input = operationReq.firstNumber;
        match input {
            int ivalue => firstNumber = ivalue;
            float fvalue => firstNumber = fvalue;
            json other => {} //error
        }

        // Pick second number for the calculate operation from the JSON request
        float secondNumber = 0;
        input = operationReq.secondNumber;
        match input {
            int ivalue => secondNumber = ivalue;
            float fvalue => secondNumber = fvalue;
            json other => {} //error
        }

        if (operation == "add" || operation == "+") {
            result = add(firstNumber, secondNumber);
        }

        // Create response message.
        json payload = { status: "Result of " + operation, result: 0.0 };
        payload["result"] = check <float>result;
        http:Response response;
        response.setJsonPayload(untaint payload);

        // Send response to the client.
        _ = client->respond(response);
    }
}