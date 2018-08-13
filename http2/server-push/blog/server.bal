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

service hello bind helloWorldEP {

    sayHello(endpoint caller, http:Request req) {

        // Send a Push Promises for 2 resources with 2 methods.
        http:PushPromise promise1 = new(path = "/resource1", method = "GET");
        http:PushPromise promise2 = new(path = "/resource2", method = "POST");
        _ = caller->promise(promise1);
        _ = caller->promise(promise2);

        // Construct the response and send.
        http:Response response = new;
        json respMsg = { "message": "response message for the original request" };
        response.setPayload(respMsg);
        _ = caller->respond(response);

        // Construct promised resource and send.
        http:Response push1 = new;
        json pushMsg1 = { "message": "push response for the sent promise1" };
        push1.setPayload(pushMsg1);
        _ = caller->pushPromisedResponse(promise1, push1);

        http:Response push2 = new;
        json pushMsg2 = { "message": "push response for the sent promise2" };
        push2.setPayload(pushMsg2);
        _ = caller->pushPromisedResponse(promise2, push2);
    }
}
