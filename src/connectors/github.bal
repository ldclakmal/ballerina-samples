import ballerina/config;
import ballerina/io;
import ballerina/log;
import wso2/github4;

github4:GitHubConfiguration gitHubConfig = {
    accessToken: config:getAsString("GITHUB_TOKEN")
};
github4:Client githubClient = new(gitHubConfig);

public function demoGitHub() {
    github4:Repository repository = {};
    var response = githubClient->getRepository("wso2-ballerina/module-github");
    if (response is github4:Repository) {
        io:println(response);
    } else {
        log:printError("Failed to get repo details", err = response);
    }
}
