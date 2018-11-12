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