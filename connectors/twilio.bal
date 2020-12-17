import ballerina/config;
import ballerina/io;
import ballerina/log;
import ballerinax/twilio;

twilio:Client twilioClient = new({
    accountSId: config:getAsString("TWILIO_ACCOUNT_SID"),
    authToken: config:getAsString("TWILIO_AUTH_TOKEN"),
    xAuthyKey: config:getAsString("TWILIO_AUTHY_API_KEY")
});

public function runTwilioTestSuite() returns boolean {
    boolean success = true;

    var accountDetails = twilioClient->getAccountDetails();
    if (accountDetails is twilio:Account) {
        io:println(accountDetails);
    } else {
        log:printError("Failed to get Twilio account details.", err = accountDetails);
        success = false;
    }

    var authyAppDetails = twilioClient->getAuthyAppDetails();
    if (authyAppDetails is twilio:AuthyAppDetailsResponse) {
        io:println(authyAppDetails);
    } else {
        log:printError("Failed to get Authy app details.", err = authyAppDetails);
        success = false;
    }

    string fromMobile = config:getAsString("TWILIO_FROM_MOBILE");
    string toMobile = config:getAsString("TWILIO_TO_MOBILE");
    string message = config:getAsString("TWILIO_MESSAGE");

    var response = twilioClient->sendSms(fromMobile, toMobile, message);
    if (response is twilio:SmsResponse) {
        io:println(response);
    } else {
        log:printError("Failed to send the SMS.", err = response);
        success = false;
    }

    return success;
}
