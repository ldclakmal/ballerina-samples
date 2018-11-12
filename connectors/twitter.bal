import ballerina/io;
import ballerina/config;
import wso2/twitter;

public function main(string... args) {
    endpoint twitter:Client twitterClient {
        clientId: config:getAsString("CLIENT_ID"),
        clientSecret: config:getAsString("CLIENT_SECRET"),
        accessToken: config:getAsString("ACCESS_TOKEN"),
        accessTokenSecret: config:getAsString("ACCESS_TOKEN_SECRET"),
        clientConfig: {}
    };
    string status = "Hello Ballerina!";

    twitter:Status twitterStatus = check twitterClient->tweet(status);
    string tweetId = <string>twitterStatus.id;
    string text = twitterStatus.text;
    io:println("Tweet ID: " + tweetId);
    io:println("Tweet: " + text);
}