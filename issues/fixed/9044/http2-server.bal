import ballerina/http;
import ballerina/log;
import ballerina/io;

endpoint http:Listener helloWorldEP {
    port: 9095,
    httpVersion: "2.0"
};

@http:ServiceConfig {
    basePath: "/hello"
}
service helloWorld bind helloWorldEP {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/get"
    }
    sayHelloGet(endpoint caller, http:Request req) {
        http:Response res = new;
        res.setPayload("*** Hello GET Response !");
        _ = caller->respond(res);
    }

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/post"
    }
    sayHelloPost(endpoint caller, http:Request req) {
        string payload = check req.getTextPayload();
        http:Response res = new;
        res.setPayload("*** Hello POST Response !");
        _ = caller->respond(res);
    }
}
