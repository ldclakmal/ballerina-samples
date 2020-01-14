import ballerina/config;
import ballerina/io;
import ballerina/log;
import ldclakmal/shoutout;

shoutout:ShoutOutConfiguration shoutOutConfig = {
    apiKey: config:getAsString("SHOUTOUT_API_KEY")
};
shoutout:Client shoutOutClient = new(shoutOutConfig);

public function demoShoutOut() {
    string toMobile = config:getAsString("SHOUTOUT_TO_MOBILE");
    string message = "This is a sample SMS sent by Ballerina connector!";
        
    var response = shoutOutClient->sendSMS(toMobile, message);
    if (response is json) {
        io:println(response);
    } else {
        log:printError("Failed to send SMS", err = response);
    }
}
