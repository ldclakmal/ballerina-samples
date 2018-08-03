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

endpoint http:Listener http2ServiceEP {
    port: 9090,
    httpVersion: "2.0"
    //keepAlive: http:KEEPALIVE_ALWAYS
};

endpoint http:Client weatherAPIClient {
    url: "https://voxd8b15ja.execute-api.us-west-2.amazonaws.com",
    secureSocket: {
        trustStore: {
            path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
    }
};

@http:ServiceConfig {
    basePath: "/http2Service"
}
service http2Service bind http2ServiceEP {

    @http:ResourceConfig {
        path: "/"
    }
    http2Resource(endpoint caller, http:Request request) {

        map<http:PushPromise> promisesMap;

        // Send a Push Promise and keep the promises in a map.
        int i = 0;
        while (i < 5) {
            http:PushPromise promise = new(path = "/", method = "GET");
            caller->promise(promise) but {
                error e => log:printError("Error occurred while sending the promise", err = e)
            };
            promisesMap[i + ""] = promise;
            i = i + 1;
        }

        // Send the response message.
        http:Response response = new;
        json msg = { "message": "Hello Ballerina - HTTP/2 Push" };
        response.setPayload(msg);
        caller->respond(response) but {
            error e => log:printError("Error occurred while sending the response", err = e)
        };

        // Call weather API for each promise and send the response back to client as a Push Promised Response.
        foreach promise in promisesMap {
            http:Request req = new;
            msg = { "city": "Colombo" };
            req.setJsonPayload(msg);
            var weatherAPIResponse = weatherAPIClient->post("/staging/hello-ballerina", req);

            match weatherAPIResponse {
                http:Response pushResponse => {
                    caller->pushPromisedResponse(promise, pushResponse) but {
                        error e => log:printError("Error occurred while sending the promised response1", err = e)
                    };
                }
                error err => log:printError(err.message);
            }
        }
    }
}