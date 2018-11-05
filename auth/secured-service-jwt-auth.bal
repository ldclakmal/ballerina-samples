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

// Create a JWT authentication provider with the relevant configuration
// parameters.
http:AuthProvider jwtAuthProvider = {
    scheme:"jwt",
    issuer:"ballerina",
    audience: "ballerina.io",
    certificateAlias: "ballerina",
    trustStore: {
        path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
        password: "ballerina"
    }
};
// The endpoint used here is `http:Listener`. The JWT authentication
// provider is set to this endpoint using the `authProviders` attribute. The
// developer has the option to override the authentication and authorization
// at the service and resource levels.
endpoint http:Listener ep {
    port: 9090,
    authProviders:[jwtAuthProvider],
    // The secure hello world sample uses https.
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
// Auth configuration comprises of two parts - authentication & authorization.
// Authentication can be enabled by setting the `authentication:{enabled:true}`
// flag.
// Authorization is based on scopes, where a scope maps to one or more groups.
// For a user to access a resource, the user should be in the same groups as
// the scope.
// To specify one or more scope of a resource, the annotation attribute
// `scopes` can be used.
service<http:Service> echo bind ep {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/sayHello",
        authConfig: {
            scopes: ["hello"]
        }
    }
    // The authentication and authorization settings can be overridden at
    // resource level.
    // The hello resource would inherit the `authentication:{enabled:true}` flag
    // from the service level, and define 'hello' as the scope for the resource.
    hello(endpoint caller, http:Request req) {
        http:Response res = new;
        res.setPayload("Hello, World!!!");
        _ = caller->respond(res);
    }
}
