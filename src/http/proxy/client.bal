import ballerina/http;
import ballerina/io;
import ballerina/log;

http:Client clientEP = new("http://dummy.restapiexample.com/api/v1", config = {
    proxy: {
        host: "127.0.0.1",
        port: 3128,
        userName: "admin",
        password: "123"
    }
});

public function main() {
    var response1 = clientEP->get("/employee/1");
    if (response1 is http:Response) {
        var payload = response1.getTextPayload();
        if (payload is string) {
            io:println("--- GET Response : " + payload);
        } else {
            log:printError(<string>payload.detail().message);
        }
    } else {
        log:printError(<string>response1.detail().message);
    }

    var response2 = clientEP->get("/employee/2");
    if (response2 is http:Response) {
        var payload = response2.getTextPayload();
        if (payload is string) {
            io:println("--- GET Response : " + payload);
        } else {
            log:printError(<string>payload.detail().message);
        }
    } else {
        log:printError(<string>response2.detail().message);
    }
}
