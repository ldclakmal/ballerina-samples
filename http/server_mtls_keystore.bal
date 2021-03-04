import ballerina/http;

listener http:Listener listenerEP = new (9090, {
    secureSocket: {
        keyStore: {
            path: "../resources/keystore/ballerinaKeystore.p12",
            password: "ballerina"
        }
        trustStore: {
            path: "../resources/keystore/ballerinaTruststore.p12",
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
