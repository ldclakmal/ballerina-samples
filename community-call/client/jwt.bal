// import ballerina/io;
// import ballerina/jwt;

// public function main() returns error? {
//     jwt:IssuerConfig issuerConfig = {
//         username: "ballerina",
//         issuer: "wso2",
//         audience: ["ballerina", "ballerina.io"],
//         expTime: 3600*24*365,
//         customClaims: {
//             "scp": "admin"
//         },
//         signatureConfig: {
//             config: {
//                 keyFile: "./resources/key/private.key"
//             }
//         }
//     };
//     string jwt = check jwt:issue(issuerConfig);
//     io:println("Issued JWT: ", jwt);
// }
