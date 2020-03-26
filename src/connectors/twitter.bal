import ballerina/config;
import ballerina/io;
import ballerina/log;
import ldclakmal/twitter;

twitter:Client twitterClient = new({
    consumerKey: config:getAsString("TWITTER_CONSUMER_KEY"),
    consumerSecret: config:getAsString("TWITTER_CONSUMER_SECRET"),
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
