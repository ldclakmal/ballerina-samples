import ballerina/io;
import ballerina/internal;
import ballerina/config;

public function main(string... args) {
    io:println("Hello, Ballerina Compression !");

    internal:Path srcPath = new("/tmp/compression/src/");
    internal:Path destPath = new("/tmp/compression/zip/dir.zip");
    var response = internal:compress(srcPath, destPath);
    match response {
        error err => io:println(err);
        () => io:println("Successfully compressed dir !");
    }

    srcPath = new("/tmp/compression/zip/dir.zip");
    destPath = new("/tmp/compression/unzip/");
    response = internal:decompress(srcPath, destPath);
    match response {
        error err => io:println(err);
        () => io:println("Successfully uncompressed dir !");
    }

    srcPath = new("/tmp/compression/src/");
    blob b;
    var res = internal:compressToBlob(srcPath);
    match res {
        error err => io:println(err);
        blob blobRes => { b = blobRes; io:println(blobRes);}
    }

    destPath = new("/tmp/compression/unzip/");
    response = internal:decompressFromBlob(b, destPath);
    match response {
        error err => io:println(err);
        () => io:println("Successfully uncompressed blob !");
    }
}
