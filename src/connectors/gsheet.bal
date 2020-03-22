import ballerina/config;
import ballerina/io;
import ballerina/log;
import ballerinax/googleapis.sheets4;

sheets4:SpreadsheetConfiguration spreadsheetConfig = {
    oAuthClientConfig: {
        accessToken: config:getAsString("GOOGLE_ACCESS_TOKEN"),
        refreshConfig: {
            refreshToken: config:getAsString("GOOGLE_REFRESH_TOKEN"),
            clientId: config:getAsString("GOOGLE_CLIENT_ID"),
            clientSecret: config:getAsString("GOOGLE_CLIENT_SECRET"),
            refreshUrl: sheets4:REFRESH_URL
        }
    }
};
sheets4:Client spreadsheetClient = new (spreadsheetConfig);

public function runGSheetsTestSuite() returns boolean {
    boolean success = true;

    var createResponse = spreadsheetClient->createSpreadsheet("Sample-Spreadsheet");
    if (createResponse is sheets4:Spreadsheet) {
        sheets4:Spreadsheet spreadsheet = createResponse;
        io:println(spreadsheet.getProperties());

        var addResponse = spreadsheet->addSheet("Sample-Sheet");
        if (addResponse is sheets4:Sheet) {
            sheets4:Sheet sheet = addResponse;
            io:println(sheet.getProperties());

            var renameResponse = sheet->rename("Sample-Sheet-RENAMED");
            if (renameResponse is error) {
                log:printError("Failed to rename the sheet", err = renameResponse);
                success = false;
            }
        } else {
            log:printError("Failed to add new sheet", err = addResponse);
            success = false;
        }
    } else {
        log:printError("Failed to create sheet", err = createResponse);
        success = false;
    }

    return success;
}
