import ballerina/http;

listener http:Listener helloWorldEP = new(9095, config = { httpVersion: "2.0" });

service hello on helloWorldEP {

    resource function sayHello(http:Caller caller, http:Request req) {
        checkpanic caller->respond("Hello " + untaint req.method + " Request !");
    }
}
