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

public function main() {
    endpoint sf:Client salesforceClient {
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
    };

    //Call the Salesforce connectors function getAvailableApiVersions().
    json|sf:SalesforceConnectorError response = salesforceClient->getAvailableApiVersions();
    match response {
        //if successful, returns JSON result
        json jsonRes => {
            io:println(jsonRes);
        }

        //if unsuccessful, returns an error of type sfdc37:SalesforceConnectorError
        sf:SalesforceConnectorError err => {
            io:println(err);
        }
    }
}