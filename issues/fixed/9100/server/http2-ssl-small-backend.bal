import ballerina/http;
import ballerina/runtime;
import ballerina/io;

endpoint http:Listener passthroughEP {
    port: 9191,
    httpVersion: "2.0",
    secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
};


@http:ServiceConfig { basePath: "/nyseStock" }
service<http:Service> nyseStockQuote bind passthroughEP {

    @http:ResourceConfig {
        path: "/stocks"
    }
    stocks(endpoint outboundEP, http:Request clientRequest) {
        http:Response res = new;
        json payload = { "foo": "bar" };
        res.setJsonPayload(payload);
        _ = outboundEP->respond(res);
    }
}
