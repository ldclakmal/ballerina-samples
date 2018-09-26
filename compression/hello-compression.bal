// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.package compression;

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
