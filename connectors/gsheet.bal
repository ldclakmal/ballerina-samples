import ballerina/config;
import ballerina/io;
import wso2/gsheets4;

gsheets4:Client spreadsheetClientEP = new({
    clientConfig: {
        auth: {
            accessToken: config:getAsString("ACCESS_TOKEN"),
            refreshToken: config:getAsString("REFRESH_TOKEN"),
            clientId: config:getAsString("CLIENT_ID"),
            clientSecret: config:getAsString("CLIENT_SECRET")
        }
    }
});

public function main() {
    var response = spreadsheetClientEP->openSpreadsheetById("abc1234567");
    if (response is gsheets4:Spreadsheet) {
        io:println(response);
    } else {
        log:printError(<string>response.detail().message);
    }
}
