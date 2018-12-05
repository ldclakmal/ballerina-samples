import ballerina/http;
import ballerina/io;
import ballerina/log;

http:Client clientEP = new("http://dummy.restapiexample.com/api/v1", config = {
    secureSocket: {
        trustStore: {
            path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
    },
    proxy: {
        host: "127.0.0.1",
        port: 3128,
        userName: "admin",
        password: "123"
    }
});

public function main() {
    var response = clientEP->get("/employee/1");
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
