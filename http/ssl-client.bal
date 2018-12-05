import ballerina/http;
import ballerina/io;
import ballerina/log;

http:Client clientEP = new("https://postman-echo.com", config = {
    secureSocket: {
        trustStore: {
            path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
    }
});

public function main() {
    var response = clientEP->get("/time/now");
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
