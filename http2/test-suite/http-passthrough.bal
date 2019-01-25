import ballerina/http;
import ballerina/log;

// --- HTTP/1.1 Listener
//listener http:Listener passthroughListener = new(9090);

// --- HTTP/1.1 Listener (SSL enabled)
//listener http:Listener passthroughListener = new(9090,
//    config = {
//        secureSocket: {
//            keyStore: {
//                path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
//                password: "ballerina"
//            }
//        }
//    }
//);

// --- HTTP/2 Listener
//listener http:Listener passthroughListener = new(9090, config = { httpVersion: "2.0" });

// --- HTTP/2 Listener (SSL enabled)
listener http:Listener passthroughListener = new(9090,
    config = {
        httpVersion: "2.0",
        secureSocket: {
            keyStore: {
                path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
                password: "ballerina"
            }
        }
    }
);

// --------------------------------------------------------------------------------------------------------------------

// --- HTTP/1.1 Client
//http:Client passthroughClient = new("http://localhost:9191");

// --- HTTP/1.1 Client (SSL enabled)
//http:Client passthroughClient = new("https://localhost:9191",
//    config = {
//        secureSocket: {
//            trustStore: {
//                path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
//                password: "ballerina"
//            }
//        }
//    }
//);

// --- HTTP/2 Client
//http:Client passthroughClient = new("http://localhost:9191", config = { httpVersion: "2.0" });

// --- HTTP/2 Client (SSL enabled)
http:Client passthroughClient = new("https://localhost:9191",
    config = {
        httpVersion: "2.0",
        secureSocket: {
            trustStore: {
                path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
                password: "ballerina"
            }
        },
        connectionThrottling: {
            maxActiveStreamsPerConnection: 1000
        }
    }
);

@http:ServiceConfig { basePath: "/passthrough" }
service passthroughService on passthroughListener {

    @http:ResourceConfig { path: "/" }
    resource function passthrough(http:Caller outboundEP, http:Request clientRequest) {
        var response = passthroughClient->forward("/hello/sayHello", clientRequest);
        if (response is http:Response) {
            _ = outboundEP->respond(response);
        } else {
            log:printError("Error at passthrough service", err = response);
            http:Response res = new;
            res.statusCode = http:INTERNAL_SERVER_ERROR_500;
            json errMsg = { message: <string>response.detail().message };
            res.setPayload(errMsg);
            _ = outboundEP->respond(res);
        }
    }
}
