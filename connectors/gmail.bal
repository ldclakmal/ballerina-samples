import ballerina/io;
import ballerina/test;
import ballerina/http;
import ballerina/config;
import wso2/gmail;

gmail:Client gmailEP = new({
    clientConfig: {
        auth: {
            scheme: http:OAUTH2,
            accessToken: config:getAsString("ACCESS_TOKEN"),
            clientId: config:getAsString("CLIENT_ID"),
            clientSecret: config:getAsString("CLIENT_SECRET"),
            refreshToken: config:getAsString("REFRESH_TOKEN")
        }
    }
});

public function main() {
    string userId = "me";
    gmail:MessageRequest messageRequest = {};
    messageRequest.recipient = config:getAsString("RECIPIENT");
    messageRequest.sender = config:getAsString("SENDER");
    messageRequest.cc = config:getAsString("CC");
    messageRequest.subject = "Email-Subject";
    messageRequest.messageBody = "Email Message Body Text";
    //Set the content type of the mail as TEXT_PLAIN or TEXT_HTML.
    messageRequest.contentType = gmail:TEXT_PLAIN;
    //Send the message.
    var sendMessageResponse = gmailEP->sendMessage(userId, messageRequest);

    string messageId = "";
    string threadId = "";
    if (sendMessageResponse is (string, string)) {
        (messageId, threadId) = sendMessageResponse;
        io:println("Sent Message ID: " + messageId);
        io:println("Sent Thread ID: " + threadId);
    } else {
        io:println(sendMessageResponse);
    }

    var readResponse = gmailEP->readMessage(userId, untaint messageId);
    if (readResponse is gmail:Message) {
        io:println("Sent Message: " + readResponse.id);
    } else {
        io:println(readResponse);
    }

    var deleteResponse = gmailEP->deleteMessage(userId, untaint messageId);
    if (deleteResponse is boolean) {
        io:println("Message deletion success!");
    } else {
        io:println(deleteResponse);
    }
}
