import ballerina/http;
import ballerina/io;

http:Client clientEP = check new ("https://localhost:9090", 
    secureSocket = {
        cert: "./resources/cert/public.crt"
    },
    auth = {
        username: "alice",
        password: "123"
    }
);

public function main() returns error? {
    string response = check clientEP->get("/foo/bar");
    io:println(response);
}
