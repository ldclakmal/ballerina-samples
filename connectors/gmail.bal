import ballerina/config;
import ballerina/io;
import ballerina/log;
import ballerinax/googleapis.gmail;

gmail:GmailConfiguration gmailConfig = {
    oauthClientConfig: {
        accessToken: config:getAsString("GOOGLE_ACCESS_TOKEN"),
        refreshConfig: {
            clientId: config:getAsString("GOOGLE_CLIENT_ID"),
            clientSecret: config:getAsString("GOOGLE_CLIENT_SECRET"),
            refreshToken: config:getAsString("GOOGLE_REFRESH_TOKEN"),
            refreshUrl: gmail:REFRESH_URL
        }
    }
};
gmail:Client gmailClient = new (gmailConfig);

public function runGMailTestSuite() returns boolean {
    boolean success = true;

    string userId = "me";
    gmail:MessageRequest messageRequest = {};
    messageRequest.recipient = config:getAsString("GMAIL_RECIPIENT");
    messageRequest.sender = config:getAsString("GMAIL_SENDER");
    messageRequest.cc = config:getAsString("GMAIL_CC");
    messageRequest.subject = "Email-Subject";
    messageRequest.messageBody = "Email Message Body Text";
    messageRequest.contentType = gmail:TEXT_PLAIN;

    string messageId = "";
    string threadId = "";
    var sendMessageResponse = gmailClient->sendMessage(userId, messageRequest);
    if (sendMessageResponse is [string, string]) {
        [messageId, threadId] = sendMessageResponse;
        io:println("Sent Message ID: " + messageId);
        io:println("Sent Thread ID: " + threadId);
    } else {
        log:printError("Failed to send the email.", err = sendMessageResponse);
        success = false;
    }

    var readResponse = gmailClient->readMessage(userId, <@untainted> messageId);
    if (readResponse is gmail:Message) {
        io:println("Sent Message: " + readResponse.id);
    } else {
        log:printError("Failed to read the email.", err = readResponse);
        success = false;
    }

    var deleteResponse = gmailClient->deleteMessage(userId, <@untainted> messageId);
    if (deleteResponse is boolean) {
        io:println("Message deletion success!");
    } else {
        log:printError("Failed to delete email", err = deleteResponse);
        success = false;
    }

    return success;
}
