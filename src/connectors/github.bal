import ballerina/config;
import ballerina/io;
import ballerina/log;
import ballerinax/github4;

github4:GitHubConfiguration gitHubConfig = {
    accessToken: config:getAsString("GITHUB_TOKEN")
};
github4:Client githubClient = new(gitHubConfig);

public function runGitHubTestSuite() returns boolean {
    boolean success = true;

    string repoOwner = "ldclakmal";
    string repoName = "ballerina-github-testing";
    var getRepoResponse = githubClient->getRepository(repoOwner + "/" + repoName);
    if (getRepoResponse is github4:Repository) {
        io:println(getRepoResponse);
    } else {
        log:printError("Failed to get repo details.", err = getRepoResponse);
    }

    string issueTitle = "This is a test issue";
    string issueBody = "This is the body of the test issue created by " +
                       "https://github.com/ldclakmal/ballerina-samples/blob/master/src/connectors/github.bal";
    string[] issueLabels = ["bug", "critical"];
    string[] assigneeList = ["ldclakmal"];
    var createIssueResponse = githubClient->createIssue(repoOwner, repoName, issueTitle, issueBody, issueLabels,
                                                        assigneeList);
    if (createIssueResponse is github4:Issue) {
        io:println(createIssueResponse);
    } else {
        log:printError("Failed to create issue.", err = createIssueResponse);
    }

    return success;
}
