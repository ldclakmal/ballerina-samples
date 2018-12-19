import ballerina/http;
import ballerina/log;

http:Client clientEP = new("http://localhost:9090");
//http:Client clientEP = new("https://localhost:9090",
//    config = {
//        secureSocket: {
//            trustStore: {
//                path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
//                password: "ballerina"
//            }
//        }
//    }
//);
//http:Client clientEP = new("http://localhost:9090", config = { httpVersion: "2.0" });
//http:Client clientEP = new("https://localhost:9090",
//    config = {
//        httpVersion: "2.0",
//        secureSocket: {
//            trustStore: {
//                path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
//                password: "ballerina"
//            }
//        }
//    }
//);

public function main() {
    var respGet = clientEP->get("/passthrough");
    if (respGet is http:Response) {
        var payload = respGet.getTextPayload();
        if (payload is string) {
            log:printInfo(payload);
        } else {
            log:printError(<string>payload.detail().message);
        }
    } else {
        log:printError(<string>respGet.detail().message);
    }

    http:Request req = new;
    req.setTextPayload("Hi, Ballerina!");

    var respPost = clientEP->post("/passthrough", req);
    if (respPost is http:Response) {
        var payload = respPost.getTextPayload();
        if (payload is string) {
            log:printInfo(payload);
        } else {
            log:printError(<string>payload.detail().message);
        }
    } else {
        log:printError(<string>respPost.detail().message);
    }
}
