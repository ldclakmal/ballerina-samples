import ballerina/io;
import ballerina/http;
import ballerina/log;

listener http:Listener httpServiceEP = new(9090);

@http:ServiceConfig {
    basePath: "/hello"
}
service hello on httpServiceEP {

    @http:ResourceConfig {
        path: "/sayHello"
    }
    resource function sayHello(http:Caller caller, http:Request req) {
        _ = caller->respond("Hello World !");
    }
}

public function main() {
    http:Client clientEP = new("http://localhost:9090");
    var response = clientEP->get("/hello/sayHello");
    if (response is http:Response) {
        io:println(response.getTextPayload());
    } else {
        log:printError("Error while invoking the endpoint", err = response);
    }
}