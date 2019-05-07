// To test the sample invoke following commands.
// 1. ballerina run http2/server.bal
// 2. curl http://localhost:9095/passthrough

import ballerina/http;

http:Client backend = new("http://localhost:9095", config = { httpVersion: "2.0" });

@http:ServiceConfig {
    basePath: "/passthrough"
}
service hello on new http:Listener(9095) {

    @http:ResourceConfig {
        path: "/"
    }
    resource function sayHello(http:Caller caller, http:Request clientRequest) {
        var clientResponse = backend->forward("/hello/sayHello", clientRequest);
        http:Response response = new;
        if (clientResponse is http:Response) {
            response = clientResponse;
        } else {
            response.statusCode = 500;
            response.setPayload(<string>clientResponse.detail().message);
        }
        checkpanic caller->respond(response);
    }
}
