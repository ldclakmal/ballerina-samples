import wso2/sfdc37 as sf;
import ballerina/config;
import ballerina/http;
import ballerina/io;

//User credentials to access Salesforce API
string url = config:getAsString("ENDPOINT");
string accessToken = config:getAsString("ACCESS_TOKEN");
string refreshToken = "<refresh_token>";
string clientId = "<client_id>";
string clientSecret = "<client_secret>";
string refreshUrl = "<refreshUrl>";

sf:Client salesforceClient = new({
    clientConfig: {
        url: url,
        auth: {
            scheme: http:OAUTH2,
            accessToken: accessToken,
            refreshToken: refreshToken,
            clientId: clientId,
            clientSecret: clientSecret,
            refreshUrl: refreshUrl
        }
    }
});

public function main() {
    var response = salesforceClient->getAvailableApiVersions();
    if (response is json) {
        io:println(response);
    } else {
        log:printError(<string>response.detail().message);
    }
}
