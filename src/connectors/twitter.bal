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

public function runTwitterTestSuite() returns boolean {
    boolean success = true;

    string status = "Hello Ballerina 1.2.0!";
    var tweetResponse = twitterClient->tweet(status);
    if (tweetResponse is twitter:Status) {
        string tweetId = tweetResponse.id.toString();
        string text = tweetResponse.text;
        io:println("Tweet ID: " + tweetId);
        io:println("Tweet: " + text);
    } else {
        log:printError("Failed to tweet.", err = tweetResponse);
        success = false;
    }

    return success;
}
