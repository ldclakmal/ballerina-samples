import ballerina/io;
import ballerina/http;
import ballerina/log;

endpoint http:Client clientEP {
    url: "https://b7a.fun",
    secureSocket: {
        trustStore: {
            path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        },
        ocspStapling: true
    }
};

public function main() {
    var resp = clientEP->get("/");

    match resp {
        http:Response response => {
            match (response.getTextPayload()) {
                string res => io:println(res);
                error err => log:printError(err.message);
            }
        }
        error err => log:printError(err.message);
    }
}