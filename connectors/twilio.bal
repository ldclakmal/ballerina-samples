import ballerina/config;
import ballerina/io;
import ballerina/log;
import wso2/twilio;

twilio:Client twilioClient = new({
        accountSId: config:getAsString("TWILIO_ACCOUNT_SID"),
        authToken: config:getAsString("TWILIO_AUTH_TOKEN"),
        xAuthyKey: config:getAsString("TWILIO_AUTHY_API_KEY")
    });

public function main() {
    var response = twilioClient->getAccountDetails();
    if (response is twilio:Account) {
        io:println(response);
    } else {
        log:printError(<string>response.detail().message);
    }

    var details = twilioClient->getAuthyAppDetails();
    if (details is twilio:AuthyAppDetailsResponse) {
        io:println(details);
    } else {
        log:printError(<string>details.detail().message);
    }
}
