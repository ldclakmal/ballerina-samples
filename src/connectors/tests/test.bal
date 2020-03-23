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
