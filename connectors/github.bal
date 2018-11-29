import ballerina/config;
import ballerina/http;
import ballerina/io;
import wso2/github4;

public function main() {
    endpoint github4:Client githubClient {
        clientConfig: {
            auth: {
                scheme: http:OAUTH2,
                accessToken: config:getAsString("GITHUB_TOKEN")
            }
        }
    };

    github4:Repository repository = {};
    var repo = githubClient->getRepository("wso2-ballerina/package-github");
    match repo {
        github4:Repository rep => {
            repository = rep;
        }
        github4:GitClientError err => {
            io:println(err);
        }
    }

    io:println(repository);
}