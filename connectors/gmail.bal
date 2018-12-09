import ballerina/config;
import ballerina/io;
import ballerina/http;
import ballerina/log;
import wso2/gmail;

gmail:Client gmailEP = new({
        clientConfig: {
            auth: {
                scheme: http:OAUTH2,
                accessToken: config:getAsString("GOOGLE_ACCESS_TOKEN"),
                clientId: config:getAsString("GOOGLE_CLIENT_ID"),
                clientSecret: config:getAsString("GOOGLE_CLIENT_SECRET"),
                refreshToken: config:getAsString("GOOGLE_REFRESH_TOKEN")
            }
        }
    });

public function main() {
    string userId = "me";
    gmail:MessageRequest messageRequest = {};
    messageRequest.recipient = config:getAsString("GMAIL_RECIPIENT");
    messageRequest.sender = config:getAsString("GMAIL_SENDER");
    messageRequest.cc = config:getAsString("GMAIL_CC");
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
        log:printError(<string>sendMessageResponse.detail().message);
    }

    var readResponse = gmailEP->readMessage(userId, untaint messageId);
    if (readResponse is gmail:Message) {
        io:println("Sent Message: " + readResponse.id);
    } else {
        log:printError(<string>readResponse.detail().message);
    }

    var deleteResponse = gmailEP->deleteMessage(userId, untaint messageId);
    if (deleteResponse is boolean) {
        io:println("Message deletion success!");
    } else {
        log:printError(<string>deleteResponse.detail().message);
    }
}
