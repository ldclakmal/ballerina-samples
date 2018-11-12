import ballerina/http;
import ballerina/log;

@final int PROMISES_COUNT = 10;

endpoint http:Listener http2ServiceEP {
    port: 9090,
    httpVersion: "2.0"
};

endpoint http:Client weatherAPIClient {
    url: "https://voxd8b15ja.execute-api.us-west-2.amazonaws.com",
    secureSocket: {
        trustStore: {
            path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
    }
};

service http2Service bind http2ServiceEP {

    http2Resource(endpoint caller, http:Request request) {

        map<http:PushPromise> promisesMap;

        // Send a Push Promise and keep the promises in a map.
        int i = 0;
        while (i < PROMISES_COUNT) {
            http:PushPromise promise = new(path = "/", method = "GET");
            caller->promise(promise) but {
                error e => log:printError("Error occurred while sending the promise", err = e)
            };
            promisesMap[i + ""] = promise;
            i = i + 1;
        }

        // Send the response message.
        http:Response response = new;
        json msg = { "message": "Hello Ballerina - HTTP/2 Push" };
        response.setPayload(msg);
        caller->respond(response) but {
            error e => log:printError("Error occurred while sending the response", err = e)
        };

        // Call weather API for each promise and send the response back to client as a Push Promised Response.
        foreach promise in promisesMap {
            http:Request req = new;
            msg = { "city": "Colombo" };
            req.setJsonPayload(msg);
            var weatherAPIResponse = weatherAPIClient->post("/staging/hello-ballerina", req);

            match weatherAPIResponse {
                http:Response pushResponse => {
                    caller->pushPromisedResponse(promise, pushResponse) but {
                        error e => log:printError("Error occurred while sending the promised response", err = e)
                    };
                }
                error err => log:printError(err.message);
            }
        }
    }
}
