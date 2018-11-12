import ballerina/http;

endpoint http:Listener listener {
    port: 9090
};

// Calculator REST service
@http:ServiceConfig { basePath: "/calculator" }
service<http:Service> Calculator bind listener {

    // Resource that handles the HTTP POST requests that are directed to
    // the path `/operation` to execute a given calculate operation
    // Sample requests for add operation in JSON format
    // `{ "firstNumber": 10, "secondNumber":  200, "operation": "add"}`
    // `{ "firstNumber": 10, "secondNumber":  20.0, "operation": "+"}`

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/operation"
    }
    executeOperation(endpoint client, http:Request req) {
        json operationReq = check req.getJsonPayload();
        string operation = operationReq.operation.toString();

        any result = 0.0;
        // Pick first number for the calculate operation from the JSON request
        float firstNumber = 0;
        var input = operationReq.firstNumber;
        match input {
            int ivalue => firstNumber = ivalue;
            float fvalue => firstNumber = fvalue;
            json other => {} //error
        }

        // Pick second number for the calculate operation from the JSON request
        float secondNumber = 0;
        input = operationReq.secondNumber;
        match input {
            int ivalue => secondNumber = ivalue;
            float fvalue => secondNumber = fvalue;
            json other => {} //error
        }

        if (operation == "add" || operation == "+") {
            result = add(firstNumber, secondNumber);
        }

        // Create response message.
        json payload = { status: "Result of " + operation, result: 0.0 };
        payload["result"] = check <float>result;
        http:Response response;
        response.setJsonPayload(untaint payload);

        // Send response to the client.
        _ = client->respond(response);
    }
}