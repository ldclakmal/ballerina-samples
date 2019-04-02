// Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
// under the License.

import ballerina/http;

// ----------- Basic auth ---------------
http:Client httpEndpoint = new("https://localhost:9090", config = {
        auth: {
            scheme: http:BASIC_AUTH,
            config: {
                username: "tom",
                password: "1234"
            }
        }
    });

// ----------- JWT auth ---------------
http:Client httpEndpoint = new("https://localhost:9090", config = {
        auth: {
            scheme: http:JWT_AUTH
        }
    });

// ----------- OAuth2 auth - client credentials grant type ---------------
http:Client clientEP1 = new("https://api.bitbucket.org/2.0", config = {
        auth: {
            scheme: http:OAUTH2,
            config: {
                grantType: http:CLIENT_CREDENTIALS_GRANT,
                config: {
                    tokenUrl: "https://bitbucket.org/site/oauth2/access_token",
                    clientId: "mMNWS9PLmM93V5WHjC",
                    clientSecret: "jLY6xPY3ER4bNTspaGu6fb7kahhs7kUa"
                }
            }
        }
    });

// ----------- OAuth2 auth - password grant type ---------------
http:Client clientEP2 = new("https://api.bitbucket.org/2.0", config = {
        auth: {
            scheme: http:OAUTH2,
            config: {
                grantType: http:PASSWORD_GRANT,
                config: {
                    tokenUrl: "https://bitbucket.org/site/oauth2/access_token",
                    username: "b7a.demo@gmail.com",
                    password: "ballerina",
                    clientId: "mMNWS9PLmM93V5WHjC",
                    clientSecret: "jLY6xPY3ER4bNTspaGu6fb7kahhs7kUa",
                    refreshConfig: {
                        refreshUrl: "https://bitbucket.org/site/oauth2/access_token"
                    }
                }
            }
        }
    });

// ----------- OAuth2 auth - direct token mode ---------------
http:Client clientEP3 = new("https://www.googleapis.com/tasks/v1", config = {
        auth: {
            scheme: http:OAUTH2,
            config: {
                grantType: http:DIRECT_TOKEN,
                config: {
                    accessToken: "ya29.GlvQBkqJS0yn0zsZm4IIUUzLk3DH1rRiCMKnHiz6deycKmTFiDsuoFlFfrmXF8dCb0gyzLyXpnv3VcrIlauj3nMs61CbydaAqMl6RwVIU2r2qg1StVVvxRWT9_Or",
                    refreshConfig: {
                        clientId: "506144513496-dqm5vdqfrfhdjjom10rmvafb8e3h7rtm.apps.googleusercontent.com",
                        clientSecret: "3hw2XN4MfiIRrv6mghX6m5gM",
                        refreshToken: "1/UwH3YyYccKTrH9bqj35Y7hMYTK9f3HEC3uzlrleFwPE",
                        refreshUrl: "https://www.googleapis.com/oauth2/v4/token"
                    }
                }
            }
        }
    });