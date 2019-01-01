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

service hello on listenerEP {

    resource function sayHello(http:Caller outboundEP, http:Request clientRequest) {
        http:Response res = new;
        var entity = clientRequest.getEntity();
        if (entity is mime:Entity) {
            res.setEntity(entity);
        } else {
            string errMsg = "An error occurred while retrieving the entity from the backend";
            log:printError(errMsg, err = entity);
            res.setPayload({ message: errMsg });
        }
        res.setHeader(http:CONTENT_TYPE, mime:APPLICATION_JSON);
        _ = outboundEP->respond(res);
    }
}
