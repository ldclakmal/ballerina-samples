import ballerina/http;
import ballerina/log;

endpoint http:Listener passthroughEP {
    port: 9090,
    httpVersion: "2.0"
};

endpoint http:Client backendEP {
    url: "http://localhost:9191",
    httpVersion: "2.0"
};

@http:ServiceConfig {
    basePath: "/passthrough"
}
service passthroughService bind passthroughEP {

    @http:ResourceConfig {
        path: "/"
    }
    passthrough(endpoint outboundEP, http:Request clientRequest) {
        //TODO: improve forward action to receive pushPromises
        var response = backendEP->forward("/backend", clientRequest);
        match response {
            http:Response httpResponse => {
                _ = outboundEP->respond(httpResponse);
            }
            error e => {
                http:Response errorResponse = new;
                log:printError("Error", err = e);
                json errMsg = { "error": "error occurred while invoking the service" };
                errorResponse.setJsonPayload(errMsg);
                _ = outboundEP->respond(errorResponse);
            }
        }
    }
}
