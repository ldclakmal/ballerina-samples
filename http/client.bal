import ballerina/io;
import ballerina/http;
import ballerina/log;

endpoint http:Client clientEP {
    url: "http://dummy.restapiexample.com/api/v1"
};

public function main(string... args) {
    var resp = clientEP->get("/employee/1");

    match resp {
        http:Response response => {
            match (response.getTextPayload()) {
                string res => io:println("--- GET Response : " + res);
                error err => log:printError(err.message);
            }
        }
        error err => log:printError(err.message);
    }

    http:Request req;
    req.setJsonPayload(
           {
               "name": "sample",
               "salary": "100",
               "age": 20
           }
    );
    var respPost = clientEP->post("/create", req);

    match respPost {
        http:Response response => {
            match (response.getTextPayload()) {
                string res => io:println("--- POST Response : " + res);
                error err => log:printError(err.message);
            }
        }
        error err => log:printError(err.message);
    }
}
