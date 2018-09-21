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
// under the License.package http2.passthrough-with-promise;

import ballerina/http;
import ballerina/log;

endpoint http:Listener passthroughEP {
    port: 9090,
    httpVersion: "2.0"
};

endpoint http:Client backendEP {
    url: "http://localhost:9191",
    httpVersion: "2.0"
};

@http:ServiceConfig {
    basePath: "/passthrough"
}
service passthroughService bind passthroughEP {

    @http:ResourceConfig {
        path: "/"
    }
    passthrough(endpoint outboundEP, http:Request clientRequest) {
        //TODO: improve forward action to receive pushPromises
        var response = backendEP->forward("/backend", clientRequest);
        match response {
            http:Response httpResponse => {
                _ = outboundEP->respond(httpResponse);
            }
            error e => {
                http:Response errorResponse = new;
                log:printError("Error", err = e);
                json errMsg = { "error": "error occurred while invoking the service" };
                errorResponse.setJsonPayload(errMsg);
                _ = outboundEP->respond(errorResponse);
            }
        }
    }
}
