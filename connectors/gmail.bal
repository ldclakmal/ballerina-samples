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
import ballerina/test;
import ballerina/config;
import wso2/gmail;

//Create an endpoint to use Gmail Connector
endpoint gmail:Client gmailEP {
    clientConfig: {
        auth: {
            accessToken: config:getAsString("ACCESS_TOKEN"),
            clientId: config:getAsString("CLIENT_ID"),
            clientSecret: config:getAsString("CLIENT_SECRET"),
            refreshToken: config:getAsString("REFRESH_TOKEN")
        }
    }
};

public function main(string... args) {
    string userId = "me";
    gmail:MessageRequest messageRequest;
    messageRequest.recipient = config:getAsString("RECIPIENT");
    messageRequest.sender = config:getAsString("SENDER");
    messageRequest.cc = config:getAsString("CC");
    messageRequest.subject = "Email-Subject";
    messageRequest.messageBody = "Email Message Body Text";
    //Set the content type of the mail as TEXT_PLAIN or TEXT_HTML.
    messageRequest.contentType = gmail:TEXT_PLAIN;
    //Send the message.
    var sendMessageResponse = gmailEP->sendMessage(userId, messageRequest);

    string messageId;
    string threadId;
    match sendMessageResponse {
        (string, string) sendStatus => {
            //If successful, returns the message ID and thread ID.
            (messageId, threadId) = sendStatus;
            io:println("Sent Message ID: " + messageId);
            io:println("Sent Thread ID: " + threadId);
        }

        //Unsuccessful attempts return a Gmail error.
        gmail:GmailError e => io:println(e);
    }

    var response = gmailEP->readMessage(userId, untaint messageId);
    match response {
        gmail:Message m => io:println("Sent Message: " + m.id);
        gmail:GmailError e => io:println(e);
    }

    var delete = gmailEP->deleteMessage(userId, untaint messageId);
    match delete {
        boolean success => io:println("Message deletion success!");
        gmail:GmailError e => io:println(e);
    }
}
