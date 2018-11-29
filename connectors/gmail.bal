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

public function main() {
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
