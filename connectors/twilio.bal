import ballerina/io;
import ballerina/log;
import ballerinax/twilio;

configurable string TWILIO_ACCOUNT_SID = ?;
configurable string TWILIO_AUTH_TOKEN = ?;
configurable string TWILIO_FROM_MOBILE = ?;
configurable string TWILIO_TO_MOBILE = ?;
configurable string TWILIO_MESSAGE = ?;

twilio:Client twilioClient = check new({
    accountSId: TWILIO_ACCOUNT_SID,
    authToken: TWILIO_AUTH_TOKEN
});

public function main() {
    var accountDetails = twilioClient->getAccountDetails();
    if (accountDetails is twilio:Account) {
        io:println(accountDetails);
    } else {
        log:printError("Failed to get Twilio account details.", 'error = accountDetails);
    }

    var response = twilioClient->sendSms(TWILIO_FROM_MOBILE, TWILIO_TO_MOBILE, TWILIO_MESSAGE);
    if (response is twilio:SmsResponse) {
        io:println(response);
    } else {
        log:printError("Failed to send the SMS.", 'error = response);
    }
}
