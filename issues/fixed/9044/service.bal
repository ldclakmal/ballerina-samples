import ballerina/io;
import ballerina/http;
import ballerina/mime;

endpoint http:Client clientEP {
    url: "http://localhost:9095",
    httpVersion: "2.0",
    followRedirects: { enabled: false }
};

endpoint http:Listener serviceEP1 {
    port: 9090,
    httpVersion: "2.0"
};

@http:ServiceConfig {
    basePath: "/service1"
}
service<http:Service> testRedirect bind serviceEP1 {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/"
    }
    redirectClient(endpoint client, http:Request req) {
        http:Request clientRequest = new;
        var response = clientEP->get("/hello/get");
        match response {
            error connectorErr => {
                io:println(connectorErr);
                _ = client->respond("Error occurred....\n");
            }
            http:Response httpResponse => {
                string payload = check httpResponse.getTextPayload();
                io:println("response: " + payload);
                http:Response finalResponse = new;
                io:println("uri: " + httpResponse.resolvedRequestedURI);
                finalResponse.setPayload(httpResponse.resolvedRequestedURI);
                _ = client->respond(finalResponse);
            }
        }
    }
}

