import ballerina/config;
import ballerina/io;
import ballerina/log;
import wso2/twitter;

twitter:Client twitterClient = new({
        clientId: config:getAsString("TWITTER_CLIENT_ID"),
        clientSecret: config:getAsString("TWITTER_CLIENT_SECRET"),
        accessToken: config:getAsString("TWITTER_ACCESS_TOKEN"),
        accessTokenSecret: config:getAsString("TWITTER_ACCESS_TOKEN_SECRET")
    });

public function main() {
    string status = "Hello Ballerina!";
    var twitterStatus = twitterClient->tweet(status);
    if (twitterStatus is twitter:Status) {
        string tweetId = <string>twitterStatus.id;
        string text = twitterStatus.text;
        io:println("Tweet ID: " + tweetId);
        io:println("Tweet: " + text);
    } else {
        log:printError(<string>twitterStatus.detail().message);
    }
}
