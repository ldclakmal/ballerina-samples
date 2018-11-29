import ballerina/http;
import ballerina/log;

endpoint http:Client clientEP {
    url: "http://localhost:9090",
    httpVersion: "2.0"
};

public function main() {

    // Submit a `GET` request.
    http:Request serviceReq = new;
    http:HttpFuture httpFuture = check clientEP->submit("POST", "/passthrough", serviceReq);

    // Get the requested resource response.
    http:Response response = check clientEP->getResponse(httpFuture);
    json responsePayload = check response.getJsonPayload();
    log:printInfo("Response : " + responsePayload.toString());

    // Check if promises exists.
    boolean hasPromise = clientEP->hasPromise(httpFuture);

    // Get the response for the promises.
    while (hasPromise) {
        http:PushPromise pushPromise = check clientEP->getNextPromise(httpFuture);
        log:printInfo("Received a promise for " + pushPromise.path);

        // Fetch required promise responses.
        http:Response promisedResponse = check clientEP->getPromisedResponse(pushPromise);
        json promisedPayload = check promisedResponse.getJsonPayload();
        log:printInfo("Promised resource : " + promisedPayload.toString());

        // Check if more promises exists.
        hasPromise = clientEP->hasPromise(httpFuture);
    }
}
