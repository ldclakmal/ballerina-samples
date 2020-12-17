import ballerina/io;
import ballerina/test;

@test:Config {}
public function testHello() {
    io:println("Testing Hello!");
}