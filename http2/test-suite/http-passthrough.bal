import ballerina/http;
import ballerina/log;

listener http:Listener passthroughListener = new(9090);
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
//listener http:Listener passthroughListener = new(9090, config = { httpVersion: "2.0" });
//listener http:Listener passthroughListener = new(9090,
//    config = {
//        httpVersion: "2.0",
//        secureSocket: {
//            keyStore: {
//                path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
//                password: "ballerina"
//            }
//        }
//    }
//);

// --------------------------------------------------------------------------------------------------------------------

http:Client passthroughClient = new("http://localhost:9191");
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
//http:Client passthroughClient = new("http://localhost:9191", config = { httpVersion: "2.0" });
//http:Client passthroughClient = new("https://localhost:9191",
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

@http:ServiceConfig { basePath: "/passthrough" }
service passthroughService on passthroughListener {

    @http:ResourceConfig { path: "/" }
    resource function passthrough(http:Caller outboundEP, http:Request clientRequest) {
        var response = passthroughClient->forward("/nyseStock/stocks", clientRequest);
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
