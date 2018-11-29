import ballerina/http;
import ballerina/io;
import ballerina/log;

http:Client clientEP = new("https://voxd8b15ja.execute-api.us-west-2.amazonaws.com", config = {
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
    var response = clientEP->get("/staging/hello-ballerina");
    if (response is http:Response) {
        var payload = response.getJsonPayload();
        if (payload is json) {
            io:println(payload);
        } else {
            log:printError(<string>payload.detail().message);
        }
    } else {
        log:printError(<string>response.detail().message);
    }
}
