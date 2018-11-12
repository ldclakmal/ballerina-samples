import ballerina/http;
import ballerina/io;
import ballerina/runtime;

endpoint http:Listener asyncServiceEP {
    port: 9090
};

@http:ServiceConfig {
    basePath: "/quote-summary"
}
service<http:Service> AsyncInvoker bind asyncServiceEP {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/"
    }
    getQuote(endpoint caller, http:Request req) {
        // The endpoint for the Stock Quote Backend service.
        endpoint http:Client nasdaqServiceEP {
            url: "http://localhost:9095",
            httpVersion: "2.0"
        };
        http:Response finalResponse = new;
        string responseStr;
        // This initializes empty json to add results from the backend call.
        json responseJson = {};

        io:println(" >> Invoking services asynchrnounsly...");

        // 'start' allows you to invoke a functions  asynchronously. Following three
        // remote invocation returns without waiting for response.

        // This calls the backend to get the stock quote for GOOG asynchronously.
        future<http:Response|error> f1 = start nasdaqServiceEP->get("/nasdaq/quote/GOOG");

        io:println(" >> Invocation completed for GOOG stock quote! Proceed without blocking for a response.");

        // This calls the backend to get the stock quote for APPL asynchronously.
        future<http:Response|error> f2 = start nasdaqServiceEP->get("/nasdaq/quote/APPL");

        io:println(" >> Invocation completed for APPL stock quote! Proceed without blocking for a response.");

        // This calls the backend to get the stock quote for MSFT asynchronously.
        future<http:Response|error> f3 = start nasdaqServiceEP->get("/nasdaq/quote/MSFT");

        io:println(" >> Invocation completed for MSFT stock quote! Proceed without blocking for a response.");

        // The ‘await` keyword blocks until the previously started async function returns.
        // Append the results from all the responses of the stock data backend.
        var response1 = await f1;
        // Use `match` to check whether the responses are available.
        // If a response is not available, an error is generated.
        match response1 {
            http:Response resp => {

                responseStr = check resp.getTextPayload();
                // Add the response from the `/GOOG` endpoint to the `responseJson` file.

                responseJson["GOOG"] = responseStr;
            }
            error err => {
                io:println(err.message);
                responseJson["GOOG"] = err.message;
            }
        }

        var response2 = await f2;
        match response2 {
            http:Response resp => {

                responseStr = check resp.getTextPayload();
                // Add the response from `/APPL` endpoint to `responseJson` file.
                responseJson["APPL"] = responseStr;
            }
            error err => {
                io:println(err.message);
                responseJson["APPL"] = err.message;
            }
        }

        var response3 = await f3;
        match response3 {
            http:Response resp => {
                responseStr = check resp.getTextPayload();
                // Add the response from the `/MSFT` endpoint to the `responseJson` file.
                responseJson["MSFT"] = responseStr;

            }
            error err => {
                io:println(err.message);
                responseJson["MSFT"] = err.message;
            }
        }

        // Send the response back to the client.
        finalResponse.setJsonPayload(untaint responseJson);
        io:println(" >> Response : " + responseJson.toString());
        _ = caller->respond(finalResponse);
    }
}