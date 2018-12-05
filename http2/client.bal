import ballerina/http;
import ballerina/log;

http:Client clientEP = new("http://localhost:9095", config = { httpVersion: "2.0" });

public function main() {
    var respGet = clientEP->get("/hello/sayHello");
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

    var respPost = clientEP->post("/hello/sayHello", req);
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
