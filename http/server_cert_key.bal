import ballerina/http;

listener http:Listener listenerEP = new (9090, {
    secureSocket: {
        certFile: "resources/cert/public.crt",
        keyFile: "resources/key/private.key"
    }
});

service /foo on listenerEP {
    resource function get bar() returns string {
        return "Hello Ballerina!";
    }
}
