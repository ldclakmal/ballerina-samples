import ballerina/io;
import chanakal/committer;

endpoint committer:Client committerReportClient {};

function main (string... args) {
    string githubUser = "ldclakmal";
    var prDetails = committerReportClient->printPullRequestList(githubUser, committer:STATE_ALL);
    match prDetails {
        () => {}
        error err => { io:println(err); }
    }

    var issueDetails = committerReportClient->printIssueList(githubUser, committer:STATE_ALL);
    match issueDetails {
        () => {}
        error err => { io:println(err); }
    }

    string userEmail = "chanakal@abc.com";
    string[] excludeEmails = ["mygroup@abc.com"];
    var emailDetails = committerReportClient->printEmailList(userEmail, excludeEmails);
    match emailDetails {
        () => {}
        error err => { io:println(err); }
    }
}
