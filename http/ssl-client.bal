import ballerina/io;
import ballerina/http;
import ballerina/log;

endpoint http:Client clientEP {
    url: "https://voxd8b15ja.execute-api.us-west-2.amazonaws.com",
    secureSocket: {
        trustStore: {
            path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
    }
};

public function main(string... args) {
    var resp = clientEP->get("/staging/hello-ballerina");

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
