import ballerina/http;
import ballerina/io;
import ballerina/log;

endpoint http:Client clientEndpoint {
    url: "http://localhost:9090"
};

public function main(string... args) {

    http:Request req = new;

    // Set the JSON payload to the message to be sent to the endpoint.
    json jsonMsg = { firstNumber: 15.6, secondNumber: 18.9, operation: "add" };
    req.setJsonPayload(jsonMsg);

    var response = clientEndpoint->post("/calculator/operation", req);
    match response {
        http:Response resp => {
            var msg = resp.getJsonPayload();
            match msg {
                json jsonPayload => {
                    string resultMessage = "Addition result " + jsonMsg["firstNumber"].toString() +
                        " + " + jsonMsg["secondNumber"].toString() + " : " +
                        jsonPayload["result"].toString();
                    io:println(resultMessage);
                }
                error err => {
                    log:printError(err.message, err = err);
                }
            }
        }
        error err => {
            log:printError(err.message, err = err);
        }
    }
}