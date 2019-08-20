import ballerina/http;
import ballerina/io;
import ballerina/log;

http:Client clientEP = new("http://dummy.restapiexample.com/api/v1");

public function main() {
    var response = clientEP->get("/employee/1");
    if (response is http:Response) {
        var payload = response.getTextPayload();
        if (payload is string) {
            io:println("--- GET Response : " + payload);
        } else {
            log:printError(<string>payload.detail().message);
        }
    } else {
        log:printError(<string>response.detail().message);
    }

    http:Request req = new;
    req.setJsonPayload(
       {
           "name": "sample",
           "salary": "100",
           "age": 20
       }
    );
    var respPost = clientEP->post("/create", req);
    if (respPost is http:Response) {
        var payload = respPost.getTextPayload();
        if (payload is string) {
            io:println("--- POST Response : " + payload);
        } else {
            log:printError(<string>payload.detail().message);
        }
    } else {
        log:printError(<string>respPost.detail().message);
    }
}
