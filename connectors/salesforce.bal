import ballerina/config;
import ballerina/io;
import ballerina/log;
import ballerinax/sfdc48;

sfdc48:SalesforceConfiguration sfConfig = {
    baseUrl: config:getAsString("SALESFORCE_ENDPOINT"),
    clientConfig: {
        accessToken: config:getAsString("SALESFORCE_ACCESS_TOKEN"),
        refreshConfig: {
            clientId: config:getAsString("SALESFORCE_CLIENT_ID"),
            clientSecret: config:getAsString("SALESFORCE_CLIENT_SECRET"),
            refreshToken: config:getAsString("SALESFORCE_REFRESH_TOKEN"),
            refreshUrl: config:getAsString("SALESFORCE_TOKEN_URL")
        }
    }
};
sfdc48:BaseClient salesforceClient = new(sfConfig);

public function runSalesforceTestSuite() returns boolean {
    boolean success = true;

    var response = salesforceClient->getOrganizationLimits();
    if (response is map<sfdc48:Limit>) {
        io:println(response);
    } else {
        log:printError("Failed to get org limits", response);
        success = false;
    }

    return success;
}
