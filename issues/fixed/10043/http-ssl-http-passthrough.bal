import ballerina/http;
import ballerina/log;

endpoint http:Listener passthroughEP {
    port: 9090,
    secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
};

endpoint http:Client nyseEP {
    url: "http://localhost:8688"
};

@http:ServiceConfig { basePath: "/passthrough" }
service<http:Service> passthroughService bind passthroughEP {

    @http:ResourceConfig {
        path: "/"
    }
    passthrough(endpoint outboundEP, http:Request clientRequest) {
        var response = nyseEP->post("/", untaint clientRequest);
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

