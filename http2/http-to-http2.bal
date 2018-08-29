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
// under the License.package http2;

import ballerina/http;
import ballerina/log;

endpoint http:Client http2serviceClientEP {
    url: "http://localhost:7090",
    httpVersion: "2.0"
};

service<http:Service> hello bind { port: 9095 } {

    sayHello(endpoint caller, http:Request clientRequest) {
        var clientResponse =
        http2serviceClientEP->forward("/http2service", clientRequest);
        http:Response response = new;
        match clientResponse {
            http:Response resultantResponse => {
                response = resultantResponse;
            }
            error err => {
                response.statusCode = 500;
                response.setPayload(err.message);
            }
        }
        caller->respond(response) but {
            error e => log:printError("Error occurred while sending the response", err = e)
        };
    }
}

endpoint http:Listener http2serviceEP {
    port: 7090,
    httpVersion: "2.0"
};

@http:ServiceConfig {
    basePath: "/http2service"
}
service http2service bind http2serviceEP {

    @http:ResourceConfig {
        path: "/"
    }
    http2Resource(endpoint caller, http:Request clientRequest) {
        http:Response response = new;
        json msg = "message: response from http2 service";
        response.setPayload(msg);
        caller->respond(response) but {
            error e => log:printError("Error occurred while sending the response", err = e)
        };
    }
}
