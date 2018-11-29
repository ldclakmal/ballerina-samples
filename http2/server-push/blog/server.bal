import ballerina/http;

listener http:Listener helloWorldEP = new(9095, config = { httpVersion: "2.0" });

service hello on helloWorldEP {

    resource function sayHello(http:Caller caller, http:Request req) {

        // Send a Push Promises for 2 resources with 2 methods.
        http:PushPromise promise1 = new(path = "/resource1", method = "GET");
        http:PushPromise promise2 = new(path = "/resource2", method = "POST");
        _ = caller->promise(promise1);
        _ = caller->promise(promise2);

        // Construct the response and send.
        http:Response response = new;
        json respMsg = { "message": "response message for the original request" };
        response.setPayload(respMsg);
        _ = caller->respond(response);

        // Construct promised resource and send.
        http:Response push1 = new;
        json pushMsg1 = { "message": "push response for the sent promise1" };
        push1.setPayload(pushMsg1);
        _ = caller->pushPromisedResponse(promise1, push1);

        http:Response push2 = new;
        json pushMsg2 = { "message": "push response for the sent promise2" };
        push2.setPayload(pushMsg2);
        _ = caller->pushPromisedResponse(promise2, push2);
    }
}
