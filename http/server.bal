import ballerina/http;

listener http:Listener helloWorldEP = new(9095);

service hello on helloWorldEP {

    resource function sayHello(http:Caller caller, http:Request req) {
        json j = { msg: "Hello " + untaint req.method + " Request !" };
        checkpanic caller->respond(j);
    }
}
