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
// under the License.package http2.async;

import ballerina/http;
import ballerina/io;
import ballerina/runtime;

endpoint http:Listener listener {
    port: 9095,
    httpVersion: "2.0"
};

@http:ServiceConfig { basePath: "/nasdaq/quote" }
service<http:Service> StockDataService bind listener {

    @http:ResourceConfig {
        path: "/GOOG", methods: ["GET"]
    }
    googleStockQuote(endpoint caller, http:Request request) {
        http:Response response = new;
        string googQuote = "GOOG, Alphabet Inc., 1013.41";
        response.setTextPayload(googQuote);
        _ = caller->respond(response);
    }

    @http:ResourceConfig {
        path: "/APPL", methods: ["GET"]
    }
    appleStockQuote(endpoint caller, http:Request request) {
        http:Response response = new;
        string applQuote = "APPL, Apple Inc., 165.22";
        response.setTextPayload(applQuote);
        _ = caller->respond(response);
    }

    @http:ResourceConfig {
        path: "/MSFT", methods: ["GET"]
    }
    msftStockQuote(endpoint caller, http:Request request) {
        http:Response response = new;
        string msftQuote = "MSFT, Microsoft Corporation, 95.35";
        response.setTextPayload(msftQuote);
        _ = caller->respond(response);
    }
}