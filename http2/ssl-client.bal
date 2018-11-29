import ballerina/http;
import ballerina/io;
import ballerina/log;

http:Client clientEP = new("https://localhost:9095", config = {
        httpVersion: "2.0",
        secureSocket: {
            trustStore: {
                path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
                password: "ballerina"
            }
        }
    });

public function main() {
    var response = clientEP->get("/hello/sayHello");
    if (response is http:Response) {
        var payload = response.getTextPayload();
        if (payload is string) {
            io:println(payload);
        } else {
            log:printError(<string>payload.detail().message);
        }
    } else {
        log:printError(<string>response.detail().message);
    }
}
