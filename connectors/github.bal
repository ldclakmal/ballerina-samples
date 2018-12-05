import ballerina/config;
import ballerina/http;
import ballerina/io;
import wso2/github4;

github4:Client githubClient = new({
    clientConfig: {
        auth: {
            scheme: http:OAUTH2,
            accessToken: config:getAsString("GITHUB_TOKEN")
        }
    }
});

public function main() {
    github4:Repository repository = {};
    var response = githubClient->getRepository("wso2-ballerina/package-github");
    if (response is github4:Repository) {
        io:println(response);
    } else {
        log:printError(<string>response.detail().message);
    }
}
