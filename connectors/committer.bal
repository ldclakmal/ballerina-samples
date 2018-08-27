// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.package connectors;

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

    string userEmail = "chanakal@wso2.com";
    string[] excludeEmails = ["vacation-group@wso2.com"];
    var emailDetails = committerReportClient->printEmailList(userEmail, excludeEmails);
    match emailDetails {
        () => {}
        error err => { io:println(err); }
    }
}
