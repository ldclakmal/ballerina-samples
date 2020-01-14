import ballerina/config;
import ballerina/io;
import ballerina/log;
import wso2/sfdc46 as sf;

sf:SalesforceConfiguration sfConfig = {
    baseUrl: config:getAsString("SALESFORCE_ENDPOINT"),
    clientConfig: {
        accessToken: config:getAsString("SALESFORCE_TOKEN_URL"),
        refreshConfig: {
            clientId: config:getAsString("SALESFORCE_CLIENT_ID"),
            clientSecret: config:getAsString("SALESFORCE_CLIENT_SECRET"),
            refreshToken: "<REFRESH_TOKEN>",
            refreshUrl: "<REFRESH_URL>"
        }
    }
};
sf:Client salesforceClient = new(sfConfig);

public function demoSalesforce() {
    var response = salesforceClient->getOrganizationLimits();
    if (response is map<sf:Limit>) {
        io:println(response);
    } else {
        log:printError("Failed to get org limits", response);
    }
}
