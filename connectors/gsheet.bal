import ballerina/config;
import ballerina/io;
import wso2/gsheets4;

public function main(string... args) {
    endpoint gsheets4:Client spreadsheetClientEP {
        clientConfig: {
            auth: {
                accessToken: config:getAsString("ACCESS_TOKEN"),
                refreshToken: config:getAsString("REFRESH_TOKEN"),
                clientId: config:getAsString("CLIENT_ID"),
                clientSecret: config:getAsString("CLIENT_SECRET")
            }
        }
    };

    gsheets4:Spreadsheet spreadsheet = new;
    var response = spreadsheetClientEP->openSpreadsheetById("abc1234567");
    match response {
        gsheets4:Spreadsheet spreadsheetRes => {
            spreadsheet = spreadsheetRes;
        }
        gsheets4:SpreadsheetError err => {
            io:println(err);
        }
    }

    io:println(spreadsheet);
}