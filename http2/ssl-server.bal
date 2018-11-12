import ballerina/io;
import ballerina/http;
import ballerina/log;

endpoint http:Listener helloWorldEP {
    port: 9095,
    httpVersion: "2.0",
    secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
};

service hello bind helloWorldEP {

    sayHello(endpoint caller, http:Request req) {
        string method = untaint req.method;
        http:Response res = new;
        res.setPayload("Hello " + method + " Request !");
        caller->respond(res) but {
            error e => log:printError("Failed to respond", err = e)
        };
    }
}
