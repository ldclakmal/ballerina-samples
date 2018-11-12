// To test the sample invoke following commands.
// 1. ballerina run http2/server.bal
// 2. curl http://localhost:9095/passthrough

import ballerina/http;
import ballerina/log;

endpoint http:Client backend {
    url: "http://localhost:9095",
    httpVersion: "2.0"
};

@http:ServiceConfig {
    basePath: "/passthrough"
}
service<http:Service> hello bind { port: 9095 } {

    @http:ResourceConfig {
        path: "/"
    }
    sayHello(endpoint caller, http:Request clientRequest) {
        var clientResponse = backend->forward("/hello/sayHello", clientRequest);
        http:Response response = new;
        match clientResponse {
            http:Response resultantResponse => {
                response = resultantResponse;
            }
            error err => {
                response.statusCode = 500;
                response.setPayload(err.message);
            }
        }
        caller->respond(response) but {
            error e => log:printError("Error occurred while sending the response", err = e)
        };
    }
}
