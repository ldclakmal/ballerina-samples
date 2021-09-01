import ballerina/http;

listener http:Listener listenerEP = new(9090, 
    secureSocket = {
        key: {
            certFile: "./resources/cert/public.crt",
            keyFile: "./resources/key/private.key"
        }
    }
);

@http:ServiceConfig {
    auth: [
        {
            fileUserStoreConfig: {},
            scopes: ["admin"]
        },
        {
            jwtValidatorConfig: {
                issuer: "wso2",
                audience: "ballerina",
                signatureConfig: {
                    certFile: "./resources/cert/public.crt"
                },
                scopeKey: "scp"
            },
            scopes: ["admin"]
        }
    ]
}
service /foo on listenerEP {
    resource function get bar() returns string {
        return "Hello, World!";
    }
}
