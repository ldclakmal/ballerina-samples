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
// under the License.package auth;

import ballerina/http;
import ballerina/log;
import ballerina/runtime;

http:AuthProvider jwtAuthProvider = {
    scheme: "jwt",
    issuer: "ballerina",
    audience: "ballerina.io",
    certificateAlias: "ballerina",
    trustStore: {
        path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
        password: "ballerina"
    }
};

endpoint http:SecureListener ep {
    port: 9090,
    authProviders: [jwtAuthProvider],
    secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        },
        trustStore: {
            path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
    }
};
@http:ServiceConfig {
    basePath: "/hello",
    authConfig: {
        authentication: { enabled: true }
    }
}
service<http:Service> echo bind ep {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/sayHello"
    }
    hello(endpoint caller, http:Request req) {
        http:Response res = new;
        res.setPayload("Hello, World !");
        _ = caller->respond(res);
    }
}