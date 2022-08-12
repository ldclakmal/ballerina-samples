import ballerina/io;
import ballerina/lang.array;
import ballerina/mime;
import ballerina/regex;
import ballerina/url;

public function main() returns error? {
    check base64EncodeDecode();
    check base64MimeEncodeDecode();
    check base64UrlSafeEncodeDecode();
    check urlEncodeDecode();
}

public function base64EncodeDecode() returns error? {
    string input = "Sömethìng!";
    string base64EncodedString = input.toBytes().toBase64();
    io:println(base64EncodedString);

    byte[] base64Decoded = check array:fromBase64(base64EncodedString);
    string base64DecodedString = check string:fromBytes(base64Decoded);
    io:println(base64DecodedString);
}

public function base64MimeEncodeDecode() returns error? {
    byte[] input = check io:fileReadBytes("./resources/sample.txt");
    byte[] base64Encoded = <byte[]>(check mime:base64Encode(input));
    string base64EncodedString = check 'string:fromBytes(base64Encoded);
    io:println(base64EncodedString);

    byte[] base64Decoded = <byte[]>(check mime:base64Decode(base64Encoded));
    string base64DecodedString = check 'string:fromBytes(base64Decoded);
    io:println(base64DecodedString);
}

public function base64UrlSafeEncodeDecode() returns error? {
    string input = "~Sömethìng!~";
    string base64EncodedString = input.toBytes().toBase64();
    string base64UrlEncodedString = regex:replaceAll(regex:replaceAll(base64EncodedString, "[+]", "-"), "[/]", "_");
    io:println(base64UrlEncodedString);

    string base64UrlDecodedString = regex:replaceAll(regex:replaceAll(base64UrlEncodedString, "[-]", "+"), "[_]", "/");
    byte[] base64Decoded = check array:fromBase64(base64UrlDecodedString);
    string base64DecodedString = check string:fromBytes(base64Decoded);
    io:println(base64DecodedString);
}

public function urlEncodeDecode() returns error? {
    string input = "http://localhost:9090/echoService?type=string&value=hello world";
    string encodedUrl = check url:encode(input, "UTF-8");
    io:println(encodedUrl);

    string decodedUrl = check url:decode(encodedUrl, "UTF-8");
    io:println(decodedUrl);
}
