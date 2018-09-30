import ballerina/http;
import ballerina/runtime;
import ballerina/io;

endpoint http:Listener passthroughEP {
    port: 9191,
    httpVersion: "2.0"
};


@http:ServiceConfig { basePath: "/nyseStock" }
service<http:Service> nyseStockQuote bind passthroughEP {

    @http:ResourceConfig {
        path: "/stocks"
    }
    stocks(endpoint outboundEP, http:Request clientRequest) {
        http:Response res = new;
        //json payload = {"foo":"bar"};
        var payload = clientRequest.getJsonPayload();
        match payload {
            json j => res.setJsonPayload(j);
            error err => io:println(err);
        }
        _ = outboundEP->respond(res);
    }
}
