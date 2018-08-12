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

import ballerina/io;
import ballerina/log;
import wso2/soap;

endpoint soap:Client soapClient {
    clientConfig: {
        url: "http://localhost:9000"
    }
};

function main(string... args) {
    log:printInfo("soapClient -> sendReceive()");

    xml body = xml `<m0:getQuote xmlns:m0="http://services.samples">
                        <m0:request>
                            <m0:symbol>WSO2</m0:symbol>
                        </m0:request>
                    </m0:getQuote>`;

    soap:SoapRequest soapRequest = {
        soapAction: "urn:getQuote",
        payload: body
    };

    var details = soapClient->sendReceive("/services/SimpleStockQuoteService", soapRequest);
    match details {
        soap:SoapResponse soapResponse => io:println(soapResponse);
        soap:SoapError soapError => io:println(soapError);
    }
}
