import ballerina/config;
import ballerina/http;
import ballerina/io;
import ballerina/log;
import wso2/sfdc37 as sf;

string url = config:getAsString("SALESFORCE_ENDPOINT");
string accessToken = config:getAsString("SALESFORCE_ACCESS_TOKEN");

sf:Client salesforceClient = new({
        baseUrl: url,
        clientConfig: {
            auth: {
                scheme: http:OAUTH2,
                accessToken: accessToken
            }
        }
    });

public function main() {
    var response = salesforceClient->getAvailableApiVersions();
    if (response is json) {
        io:println(response);
    } else {
        log:printError(<string>response.message);
    }
}
