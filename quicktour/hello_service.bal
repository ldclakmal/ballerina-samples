import ballerina/config;
import ballerina/http;
import wso2/twitter;
import ballerinax/docker;

endpoint twitter:Client twitterEP {
    clientId: config:getAsString("consumerKey"),
    clientSecret: config:getAsString("consumerSecret"),
    accessToken: config:getAsString("accessToken"),
    accessTokenSecret: config:getAsString("accessTokenSecret")
};

// Docker configurations
@docker:Config {
    registry:"registry.hub.docker.com",
    name:"helloworld",
    tag:"v1.0"
}
@docker:CopyFiles {
    files:[
        {source:"./twitter.toml", target:"/home/ballerina/conf/twitter.toml", isBallerinaConf:true}
    ]
}
@docker:Expose {}
endpoint http:Listener listener {
    port: 9090
};

@http:ServiceConfig {
    basePath: "/"
}
service<http:Service> hello bind listener {

    @http:ResourceConfig {
        path: "/"
    }
    sayHello (endpoint caller, http:Request request) {
        string status = check request.getTextPayload();
        twitter:Status st = check twitterEP->tweet(status, "", "");

        http:Response response = new;
        response.setTextPayload("ID:" + <string>st.id + "\n");

        _ = caller->respond(response);
    }
}
