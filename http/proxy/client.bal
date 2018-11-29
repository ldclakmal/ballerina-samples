import ballerina/io;
import ballerina/http;
import ballerina/log;

endpoint http:Client clientEP {
    url: "http://dummy.restapiexample.com/api/v1",
    proxy: {
        host: "127.0.0.1",
        port: 3128,
        userName: "admin",
        password: "123"
    }
};

public function main() {
    var resp1 = clientEP->get("/employee/1");

    match resp1 {
        http:Response response => {
            match (response.getTextPayload()) {
                string res => io:println("--- GET Response : " + res);
                error err => log:printError(err.message);
            }
        }
        error err => log:printError(err.message);
    }

    var resp2 = clientEP->get("/employee/2");

    match resp2 {
        http:Response response => {
            match (response.getTextPayload()) {
                string res => io:println("--- GET Response : " + res);
                error err => log:printError(err.message);
            }
        }
        error err => log:printError(err.message);
    }
}
