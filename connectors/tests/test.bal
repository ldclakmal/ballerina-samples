import ballerina/io;
import ballerina/test;

@test:Config {}
function testTwilioConnector() {
    io:println("-- Twilio Connector --");
    boolean result = runTwilioTestSuite();
    test:assertTrue(result);
}

@test:Config {}
function testGMailConnector() {
    io:println("-- GMail Connector --");
    boolean result = runGMailTestSuite();
    test:assertTrue(result);
}

@test:Config {}
function testGSheetsConnector() {
    io:println("-- GSheets Connector --");
    boolean result = runGSheetsTestSuite();
    test:assertTrue(result);
}

@test:Config {}
function testGitHubConnector() {
    io:println("-- GitHub Connector --");
    boolean result = runGitHubTestSuite();
    test:assertTrue(result);
}

@test:Config {}
function testSalesforceConnector() {
    io:println("-- Salesforce Connector --");
    boolean result = runSalesforceTestSuite();
    test:assertTrue(result);
}

@test:Config {}
function testTwitterConnector() {
    io:println("-- Twitter Connector --");
    boolean result = runTwitterTestSuite();
    test:assertTrue(result);
}
