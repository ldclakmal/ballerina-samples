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
// under the License.package connector;

import ballerina/config;
import ballerina/io;
import wso2/twilio;

function main (string... args) {
    endpoint twilio:Client twilioClient {
        accountSId:config:getAsString("ACCOUNT_SID"),
        authToken:config:getAsString("AUTH_TOKEN"),
        xAuthyKey:config:getAsString("AUTHY_API_KEY")
    };

    var details = twilioClient->getAccountDetails();
    match details {
        twilio:Account account => io:println(account);
        twilio:TwilioError twilioError => io:println(twilioError);
    }
}