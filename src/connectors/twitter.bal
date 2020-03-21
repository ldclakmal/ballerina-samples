//import ballerina/config;
//import ballerina/io;
//import wso2/twitter;
//
//twitter:Client twitterClient = new({
//    clientId: config:getAsString("TWITTER_CLIENT_ID"),
//    clientSecret: config:getAsString("TWITTER_CLIENT_SECRET"),
//    accessToken: config:getAsString("TWITTER_ACCESS_TOKEN"),
//    accessTokenSecret: config:getAsString("TWITTER_ACCESS_TOKEN_SECRET")
//});
//
//public function demoTwitter() {
//    string status = "Hello Ballerina 1.0.0!";
//    var twitterStatus = twitterClient->tweet(status);
//    if (twitterStatus is twitter:Status) {
//        string tweetId = twitterStatus.id.toString();
//        string text = twitterStatus.text;
//        io:println("Tweet ID: " + tweetId);
//        io:println("Tweet: " + text);
//    } else {
//        io:println(twitterStatus);
//    }
//}
