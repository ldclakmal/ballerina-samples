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

function main(string... args) {

    // Submit a `GET` request.
    http:Request serviceReq = new;
    http:HttpFuture httpFuture = new;
    var submissionResult = clientEP->submit("GET", "/hello/sayHello", serviceReq);
    match submissionResult {
        http:HttpFuture resultantFuture => {
            httpFuture = resultantFuture;
        }
        error resultantErr => {
            log:printError("Error occurred while submitting a request", err = resultantErr);
            return;
        }
    }

    // Check if promises exists.
    boolean hasPromise = clientEP->hasPromise(httpFuture);

    // Get the next promise.
    http:PushPromise pushPromise = new;
    if (hasPromise) {
        var nextPromiseResult = clientEP->getNextPromise(httpFuture);
        match nextPromiseResult {
            http:PushPromise resultantPushPromise => {
                pushPromise = resultantPushPromise;
            }
            error resultantErr => {
                log:printError("Error occurred while fetching a push promise", err = resultantErr);
                return;
            }
        }
        log:printInfo("Received a promise for " + pushPromise.path);
    }

    // Get the requested resource response.
    http:Response response = new;
    var responseResult = clientEP->getResponse(httpFuture);
    match responseResult {
        http:Response resultantResponse => {
            response = resultantResponse;
        }
        error resultantErr => {
            log:printError("Error occurred while fetching response", err = resultantErr);
            return;
        }
    }
    var responsePayload = response.getJsonPayload();
    match responsePayload {
        json resultantJsonPayload =>
        log:printInfo("Response : " + resultantJsonPayload.toString());
        error e =>
        log:printError("Expected response payload not received", err = e);
    }

    // Fetch required promise responses.
    http:Response promisedResponse = new;
    var promisedResponseResult = clientEP->getPromisedResponse(pushPromise);
    match promisedResponseResult {
        http:Response resultantPromisedResponse => {
            promisedResponse = resultantPromisedResponse;
        }
        error resultantErr => {
            log:printError("Error occurred while fetching promised response", err = resultantErr);
            return;
        }
    }
    var promisedPayload = promisedResponse.getJsonPayload();
    match promisedPayload {
        json promisedJsonPayload =>
        log:printInfo("Promised resource : " + promisedJsonPayload.toString());
        error e =>
        log:printError("Expected promised response payload not received", err = e);
    }
}
