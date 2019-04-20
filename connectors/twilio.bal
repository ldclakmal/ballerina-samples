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
    var accountDetails = twilioClient->getAccountDetails();
    if (accountDetails is twilio:Account) {
        io:println(accountDetails);
    } else {
        log:printError(<string>accountDetails.detail().message);
    }

    var authyDetails = twilioClient->getAuthyAppDetails();
    if (authyDetails is twilio:AuthyAppDetailsResponse) {
        io:println(authyDetails);
    } else {
        log:printError(<string>authyDetails.detail().message);
    }

    string fromMobile = config:getAsString("TWILIO_SAMPLE_FROM_MOBILE");
    string toMobile = config:getAsString("TWILIO_SAMPLE_TO_MOBILE");
    string message = config:getAsString("TWILIO_SAMPLE_MESSAGE");

    var response = twilioClient->sendSms(fromMobile, toMobile, message);
    if (response is twilio:SmsResponse) {
        io:println(response);
    } else {
        log:printError(<string>response.detail().message);
    }
}
