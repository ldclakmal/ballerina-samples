import ballerina/http;

listener http:Listener listenerEP = new (9090, {
    secureSocket: {
        keyStore: {
            path: "sample/resources/keystore/ballerinaKeystore.p12",
            password: "ballerina"
        }
        trustStore: {
            path: "sample/resources/keystore/ballerinaTruststore.p12",
            password: "ballerina"
        },
        sslVerifyClient: "require"
    }
});

service /foo on listenerEP {
    resource function get bar() returns string {
        return "Hello Ballerina!";
    }
}
