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
// under the License.package http2.server-push;

import ballerina/http;
import ballerina/log;

endpoint http:Client clientEP {
    url: "http://localhost:9095",
    httpVersion: "2.0"
};

public function main(string... args) {

    // Submit a `GET` request.
    http:Request serviceReq = new;
    http:HttpFuture httpFuture = check clientEP->submit("GET", "/hello/sayHello", serviceReq);

    // Get the requested resource response.
    http:Response response = check clientEP->getResponse(httpFuture);
    json responsePayload = check response.getJsonPayload();
    log:printInfo("Response : " + responsePayload.toString());

    // Check if promises exists.
    boolean hasPromise = clientEP->hasPromise(httpFuture);

    // Get the response for the promises.
    while (hasPromise) {
        http:PushPromise pushPromise = check clientEP->getNextPromise(httpFuture);
        log:printInfo("Received a promise for " + pushPromise.path);

        // Fetch required promise responses.
        http:Response promisedResponse = check clientEP->getPromisedResponse(pushPromise);
        json promisedPayload = check promisedResponse.getJsonPayload();
        log:printInfo("Promised resource : " + promisedPayload.toString());

        // Check if more promises exists.
        hasPromise = clientEP->hasPromise(httpFuture);
    }
}
