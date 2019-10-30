import ballerina/config;
import ballerina/io;
import ballerina/log;
import wso2/gsheets4;

gsheets4:SpreadsheetConfiguration spreadsheetConfig = {
    oAuthClientConfig: {
        accessToken: config:getAsString("GOOGLE_ACCESS_TOKEN"),
        refreshConfig: {
            refreshToken: config:getAsString("GOOGLE_REFRESH_TOKEN"),
            clientId: config:getAsString("GOOGLE_CLIENT_ID"),
            clientSecret: config:getAsString("GOOGLE_CLIENT_SECRET"),
            refreshUrl: gsheets4:REFRESH_URL
        }
    }
};
gsheets4:Client spreadsheetClient = new (spreadsheetConfig);

public function main() {
    gsheets4:Spreadsheet testSheet = new;
    int testSheetId = 0;

    var createResponse = spreadsheetClient->createSpreadsheet("Sample-Spreadsheet");
    if (createResponse is gsheets4:Spreadsheet) {
        testSheet = createResponse;
        io:println(createResponse);
    } else {
        log:printError("Failed to create sheet", err = createResponse);
    }

    var addResponse = spreadsheetClient->addNewSheet(<@untainted> testSheet.spreadsheetId, "Sample-Sheet");
    if (addResponse is gsheets4:Sheet) {
        testSheetId = addResponse.properties.sheetId;
        io:println(addResponse);
    } else {
        log:printError("Failed to add new sheet", err = addResponse);
    }

    var deleteResponse = spreadsheetClient->deleteSheet(<@untainted> testSheet.spreadsheetId, <@untainted> testSheetId);
    if (deleteResponse is boolean) {
        io:println(deleteResponse);
    } else {
        log:printError("Failed to delete sheet", err = deleteResponse);
    }
}
