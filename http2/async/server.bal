import ballerina/http;
import ballerina/io;
import ballerina/runtime;

endpoint http:Listener listener {
    port: 9095,
    httpVersion: "2.0"
};

@http:ServiceConfig { basePath: "/nasdaq/quote" }
service<http:Service> StockDataService bind listener {

    @http:ResourceConfig {
        path: "/GOOG", methods: ["GET"]
    }
    googleStockQuote(endpoint caller, http:Request request) {
        http:Response response = new;
        string googQuote = "GOOG, Alphabet Inc., 1013.41";
        response.setTextPayload(googQuote);
        _ = caller->respond(response);
    }

    @http:ResourceConfig {
        path: "/APPL", methods: ["GET"]
    }
    appleStockQuote(endpoint caller, http:Request request) {
        http:Response response = new;
        string applQuote = "APPL, Apple Inc., 165.22";
        response.setTextPayload(applQuote);
        _ = caller->respond(response);
    }

    @http:ResourceConfig {
        path: "/MSFT", methods: ["GET"]
    }
    msftStockQuote(endpoint caller, http:Request request) {
        http:Response response = new;
        string msftQuote = "MSFT, Microsoft Corporation, 95.35";
        response.setTextPayload(msftQuote);
        _ = caller->respond(response);
    }
}