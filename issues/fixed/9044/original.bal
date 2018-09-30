import ballerina/io;
import ballerina/http;
import ballerina/mime;

endpoint http:Listener serviceEndpoint {
    port: 9090,
    httpVersion: "2.0"
};

endpoint http:Listener serviceEndpoint2 {
    port: 9093,
    httpVersion: "2.0"
};

endpoint http:Client endPoint3 {
    url: "http://localhost:9093",
    httpVersion: "2.0",
    followRedirects: { enabled: false }
};

@http:ServiceConfig {
    basePath: "/service1"
}
service<http:Service> testRedirect bind serviceEndpoint {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/"
    }
    redirectClient(endpoint client, http:Request req) {
        http:Request clientRequest = new;
        var response = endPoint3->get("/redirect2");
        http:Response finalResponse = new;
        match response {
            error connectorErr => {
                io:println(connectorErr.message);
            }
            http:Response httpResponse => {
                io:println(httpResponse.resolvedRequestedURI);
                finalResponse.setPayload(httpResponse.resolvedRequestedURI);
                _ = client->respond(finalResponse);
            }
        }
    }


}

@http:ServiceConfig {
    basePath: "/redirect2"
}
service<http:Service> redirect2 bind serviceEndpoint2 {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/"
    }
    redirect2(endpoint client, http:Request req) {
        http:Response res = new;
        res.setPayload("hello world");
        _ = client->respond(res);
    }
}
