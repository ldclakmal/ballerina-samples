import ballerina/config;
import ballerina/log;
import chanakal/committer;

committer:CommitterReportConfiguration committerReportConfig = {
    githubToken: config:getAsString("GITHUB_TOKEN"),
    gmailAccessToken: config:getAsString("COMMITTER_ACCESS_TOKEN"),
    gmailClientId: config:getAsString("COMMITTER_CLIENT_ID"),
    gmailClientSecret: config:getAsString("COMMITTER_CLIENT_SECRET"),
    gmailRefreshToken: config:getAsString("COMMITTER_REFRESH_TOKEN")
};

committer:Client committerReportClient = new(committerReportConfig);

public function main() {
    string githubUser = "ldclakmal";
    var prDetails = committerReportClient->printPullRequestList(githubUser, committer:STATE_ALL);
    if (prDetails is error) {
        log:printError(<string>prDetails.detail().message);
    }

    var issueDetails = committerReportClient->printIssueList(githubUser, committer:STATE_ALL);
    if (issueDetails is error) {
        log:printError(<string>issueDetails.detail().message);
    }

    string userEmail = "ldclakmal@gmail.com";
    string[] excludeEmails = ["mygroup@abc.com"];
    var emailDetails = committerReportClient->printEmailList(userEmail, excludeEmails);
    if (emailDetails is error) {
        log:printError(<string>emailDetails.detail().message);
    }
}
