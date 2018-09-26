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
// under the License.package connectors;

import ballerina/config;
import ballerina/io;
import wso2/gsheets4;

public function main(string... args) {
    endpoint gsheets4:Client spreadsheetClientEP {
        clientConfig: {
            auth: {
                accessToken: config:getAsString("ACCESS_TOKEN"),
                refreshToken: config:getAsString("REFRESH_TOKEN"),
                clientId: config:getAsString("CLIENT_ID"),
                clientSecret: config:getAsString("CLIENT_SECRET")
            }
        }
    };

    gsheets4:Spreadsheet spreadsheet = new;
    var response = spreadsheetClientEP->openSpreadsheetById("abc1234567");
    match response {
        gsheets4:Spreadsheet spreadsheetRes => {
            spreadsheet = spreadsheetRes;
        }
        gsheets4:SpreadsheetError err => {
            io:println(err);
        }
    }

    io:println(spreadsheet);
}