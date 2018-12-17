import ballerina/http;
import ballerina/log;
import ballerina/mime;

listener http:Listener listenerEP = new(9191);
//listener http:Listener listenerEP = new(9191,
//    config = {
//        secureSocket: {
//            keyStore: {
//                path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
//                password: "ballerina"
//            }
//        }
//    }
//);


// --------------------------------------
//            HTTP/2 listeners
// --------------------------------------

//listener http:Listener listenerEP = new(9191, config = { httpVersion: "2.0" });
//listener http:Listener listenerEP = new(9191,
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

@http:ServiceConfig { basePath: "/nyseStock" }
service nyseStockQuote on listenerEP {

    @http:ResourceConfig { path: "/stocks" }
    resource function stocks(http:Caller outboundEP, http:Request clientRequest) {
        http:Response res = new;
        var payload = clientRequest.getJsonPayload();
        if (payload is json) {
            res.setPayload(untaint payload);
        } else {
            string errMsg = "Received payload is not json compatible";
            log:printError(errMsg, err = payload);
            res.setPayload({ message: errMsg });
        }
        res.setHeader(http:CONTENT_TYPE, mime:APPLICATION_JSON);
        _ = outboundEP->respond(res);
    }
}
