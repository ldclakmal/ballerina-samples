import ballerina/io;
import ballerina/http;
import ballerina/mime;

endpoint http:Listener httpListener {
    port: 9090
};

service<http:Service> hello bind httpListener {
    sayHello(endpoint conn, http:Request req) {
        string header = req.getHeader("Authorization");
        io:println("Header value : " + header);
        _ = conn->respond(new);
    }
}

endpoint http:Client httpClient { url: "http://localhost:9090" };

function main(string... args) {
    http:Request req = new;
    req.setHeader("Authorization", "1");

    var response = httpClient->get("/hello/sayHello", request = req);
    match response {
        http:Response res => io:println(res);
        http:error err => io:println(err);
    }

    req.setHeader("Authorization", "2");

    response = httpClient->get("/hello/sayHello", request = req);
    match response {
        http:Response res => io:println(res);
        http:error err => io:println(err);
    }
}
