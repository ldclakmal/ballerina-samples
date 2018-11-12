import ballerina/http;
import ballerina/log;

endpoint http:Client clientEP {
    url: "http://localhost:9095",
    httpVersion: "2.0"
};

public function main(string... args) {
    var respGet = clientEP->get("/hello/sayHello");

    match respGet {
        http:Response response => {
            match (response.getTextPayload()) {
                string res => log:printInfo(res);
                error err => log:printError(err.message);
            }
        }
        error err => log:printError(err.message);
    }

    http:Request req;
    req.setTextPayload("Hi, Ballerina!");

    var respPost = clientEP->post("/hello/sayHello", req);
    match respPost {
        http:Response response => {
            match (response.getTextPayload()) {
                string res => log:printInfo(res);
                error err => log:printError(err.message);
            }
        }
        error err => log:printError(err.message);
    }
}
