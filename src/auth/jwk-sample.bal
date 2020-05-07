import ballerina/io;
import ballerina/jwt;
import ballerina/log;

public function main() {
    string jwt = "eyJ4NXQiOiJOVEF4Wm1NeE5ETXlaRGczTVRVMVpHTTBNekV6T0RKaFpXSTRORE5sWkRVMU9HRmtOakZpTVEiLCJraWQiOiJOVE" +
    "F4Wm1NeE5ETXlaRGczTVRVMVpHTTBNekV6T0RKaFpXSTRORE5sWkRVMU9HRmtOakZpTVEiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhZG1pbkBj" +
    "YXJib24uc3VwZXIiLCJhdWQiOiJ2RXd6YmNhc0pWUW0xalZZSFVIQ2poeFo0dFlhIiwibmJmIjoxNTg3NjIxODkwLCJhenAiOiJ2RXd6YmNhc0p" +
    "WUW0xalZZSFVIQ2poeFo0dFlhIiwiaXNzIjoiaHR0cHM6XC9cL2xvY2FsaG9zdDo5NDQzXC9vYXV0aDJcL3Rva2VuIiwiZXhwIjo0NzQxMjIxOD" +
    "kwLCJpYXQiOjE1ODc2MjE4OTAsImp0aSI6ImFiZWFlMjIyLWViNzctNDg2Mi05MTZkLTM0NjIyZDRlNGFmYyJ9.IoD0-39h7vEAoDdnKBRtWC6t" +
    "pTyADsGyXomHbsCj_oR5B8lj7jVUG2TCKoMXD_S_BV3F3ep7zENOW8wu0M7F27yJsgas5-vJ7BO1IMLD82PReeb160CnJ2tUFrmdT1Gc7uNfXfX" +
    "uJv7qwkgaWR0VvFCfsvl88UQXyXA0rEmNYT4p_jFjKovgPsPePl6Qf0uwO--xEhGEM4cUuBog2bgY54vaLg9iHnNb6ZZ_EZvjwIONZseBOiB5IX" +
    "DzffUXnPfwUsGaygHqw71byV61VQhDLFDsm7Jrqe3cpd8hThAUHhVkgsz3irwXPolOdlMheslOIMunVcnQLT6yvGlsrHxS0g";

    jwt:JwtValidatorConfig validatorConfig = {
        issuer: "https://localhost:9443/oauth2/token",
        audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
        signatureConfig: {
            url: "https://asb0zigfg2.execute-api.us-west-2.amazonaws.com/v1/jwks"
        }
    };

    jwt:JwtPayload|jwt:Error result = jwt:validateJwt(jwt, validatorConfig);
    if (result is jwt:JwtPayload) {
        io:println(result);
    } else {
        log:printError("Failed to validate JWT: ", result);
    }
}
