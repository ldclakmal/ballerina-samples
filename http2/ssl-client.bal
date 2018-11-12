import ballerina/io;
import ballerina/http;
import ballerina/log;

endpoint http:Client clientEP {
    url: "https://localhost:9095",
    httpVersion: "2.0",
    secureSocket: {
        trustStore: {
            path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
    }
};

public function main(string... args) {
    var resp = clientEP->get("/hello/sayHello");

    match resp {
        http:Response response => {
            match (response.getJsonPayload()) {
                json res => io:println(res);
                error err => log:printError(err.message);
            }
        }
        error err => log:printError(err.message);
    }
}
