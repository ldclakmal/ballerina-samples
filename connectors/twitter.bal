import ballerina/io;
import ballerina/config;
import wso2/twitter;

twitter:Client twitterClient = new({
    clientId: config:getAsString("CLIENT_ID"),
    clientSecret: config:getAsString("CLIENT_SECRET"),
    accessToken: config:getAsString("ACCESS_TOKEN"),
    accessTokenSecret: config:getAsString("ACCESS_TOKEN_SECRET")
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
        io:println(<string>twitterStatus.detail().message);
    }
}
