import ballerina/http;
import ballerina/log;

listener http:Listener passthroughEP = new(9090, config = { httpVersion: "2.0" });

http:Client backendEP = new("http://localhost:9191", config = { httpVersion: "2.0" });

@http:ServiceConfig {
    basePath: "/passthrough"
}
service passthroughService on passthroughEP {

    @http:ResourceConfig {
        path: "/"
    }
    resource function passthrough(http:Caller outboundEP, http:Request clientRequest) {
        //TODO: improve forward action to receive pushPromises
        var response = backendEP->forward("/backend", clientRequest);
        if (response is http:Response) {
            _ = outboundEP->respond(response);
        } else {
            log:printError(<string>response.detail().message);
            _ = outboundEP->respond({ "error": "error occurred while invoking the service" });
        }
    }
}
