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

endpoint http:Listener helloWorldEP {
    port: 9095,
    httpVersion: "2.0"

};

@http:ServiceConfig
service hello bind helloWorldEP {

    @http:ResourceConfig
    sayHello(endpoint caller, http:Request req) {

        // Send a Push Promise.
        http:PushPromise promise = new(path = "/resource", method = "GET");
        _ = caller->promise(promise);

        // Construct the requested resource and send.
        http:Response response = new;
        json msg = { "message": "response message for the original request" };
        response.setPayload(msg);
        _ = caller->respond(response);

        // Construct promised resource and send.
        http:Response push = new;
        msg = { "message": "push response for the sent promise" };
        push.setPayload(msg);
        _ = caller->pushPromisedResponse(promise, push);
    }
}