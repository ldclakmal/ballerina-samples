import ballerina/config;
import ballerina/http;
import ballerina/io;
import ballerina/log;
import wso2/sfdc37 as sf;

string baseUrl = config:getAsString("SALESFORCE_ENDPOINT");
string tokenUrl = config:getAsString("SALESFORCE_TOKEN_URL");
string username = config:getAsString("SALESFORCE_USERNAME");
string password = config:getAsString("SALESFORCE_PASSWORD");
string clientId = config:getAsString("SALESFORCE_CLIENT_ID");
string clientSecret = config:getAsString("SALESFORCE_CLIENT_SECRET");

sf:Client salesforceClient = new({
        baseUrl: baseUrl,
        clientConfig: {
            auth: {
                scheme: http:OAUTH2,
                config: {
                    grantType: http:PASSWORD_GRANT,
                    config: {
                        tokenUrl: tokenUrl,
                        username: username,
                        password: password,
                        clientId: clientId,
                        clientSecret: clientSecret,
                        credentialBearer: http:POST_BODY_BEARER
                    }
                }
            }
        }
    });

public function main() {
    var response = salesforceClient->getOrganizationLimits();
    if (response is json) {
        io:println(response);
    } else {
        log:printError(<string>response.message);
    }
}
