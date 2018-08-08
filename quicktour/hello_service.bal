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
// under the License.package quicktour;

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
// under the License.package sample;

import ballerina/config;
import ballerina/http;
import wso2/twitter;
import ballerinax/docker;

endpoint twitter:Client twitterEP {
    clientId: config:getAsString("consumerKey"),
    clientSecret: config:getAsString("consumerSecret"),
    accessToken: config:getAsString("accessToken"),
    accessTokenSecret: config:getAsString("accessTokenSecret")
};

// Docker configurations
@docker:Config {
    registry:"registry.hub.docker.com",
    name:"helloworld",
    tag:"v1.0"
}
@docker:CopyFiles {
    files:[
        {source:"./twitter.toml", target:"/home/ballerina/conf/twitter.toml", isBallerinaConf:true}
    ]
}
@docker:Expose {}
endpoint http:Listener listener {
    port: 9090
};

@http:ServiceConfig {
    basePath: "/"
}
service<http:Service> hello bind listener {

    @http:ResourceConfig {
        path: "/"
    }
    sayHello (endpoint caller, http:Request request) {
        string status = check request.getTextPayload();
        twitter:Status st = check twitterEP->tweet(status, "", "");

        http:Response response = new;
        response.setTextPayload("ID:" + <string>st.id + "\n");

        _ = caller->respond(response);
    }
}
