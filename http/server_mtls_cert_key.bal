import ballerina/http;

listener http:Listener listenerEP = new (9090, {
    secureSocket: {
        certFile: "sample/resources/cert/public.crt",
        keyFile: "sample/resources/key/private.key",
        trustedCertFile: "sample/resources/cert/public.crt",
        sslVerifyClient: "require"
    }
});

service /foo on listenerEP {
    resource function get bar() returns string {
        return "Hello Ballerina!";
    }
}
