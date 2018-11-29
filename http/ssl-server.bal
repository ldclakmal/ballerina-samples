import ballerina/http;

listener http:Listener helloWorldEP = new(9095, config = {
    secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

service hello on helloWorldEP {

    resource function sayHello(http:Caller caller, http:Request req) {
        _ = caller->respond("Hello " + untaint req.method + " Request !");
    }
}
