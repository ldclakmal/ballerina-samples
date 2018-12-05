import ballerina/io;
import chanakal/committer;

committer:Client committerReportClient = new();

public function main() {
    string githubUser = "ldclakmal";
    var prDetails = committerReportClient->printPullRequestList(githubUser, committer:STATE_ALL);
    if (prDetails is error) {
        io:println(prDetails);
    }

    var issueDetails = committerReportClient->printIssueList(githubUser, committer:STATE_ALL);
    if (issueDetails is error) {
        io:println(issueDetails);
    }

    string userEmail = "chanakal@abc.com";
    string[] excludeEmails = ["mygroup@abc.com"];
    var emailDetails = committerReportClient->printEmailList(userEmail, excludeEmails);
    if (emailDetails is error) {
        io:println(emailDetails);
    }
}
