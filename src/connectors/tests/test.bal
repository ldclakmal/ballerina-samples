import ballerina/io;
import ballerina/test;

@test:Config {}
function testTwilioConnector() {
    io:println("-- Twilio Connector --");
    boolean result = runTestSuite();
    test:assertTrue(result);
}
