import ballerina/http;

listener http:Listener listenerEP = new (9090, {
    secureSocket: {
        keyStore: {
            path: "../resources/keystore/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

service /foo on listenerEP {
    resource function get bar() returns string {
        return "Hello Ballerina!";
    }
}
