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
// under the License.package calculator;

import ballerina/io;

function main(string... args) {

    int operation = 0;
    while (operation != 5) {
        // print options menu to choose from
        io:println("Select operation.");
        io:println("1. Add");
        io:println("2. Subtract");
        io:println("3. Multiply");
        io:println("4. Divide");
        io:println("5. Exit");

        // read user's choice
        string choice = io:readln("Enter choice 1 - 5: ");
        operation = check <int>choice;

        if (operation == 5) {
            break;
        } else if (operation < 1 || operation > 5) {
            io:println("Invalid choice \n");
            continue;
        }

        // Read two numbers from user to be used for calculator operations
        var input1 = io:readln("Enter first number: ");
        float firstNumber = check <float>input1;
        var input2 = io:readln("Enter second number: ");
        float secondNumber = check <float>input2;

        // Execute calculator operations based on user's choice
        if(operation == 1) {
            io:print("Add result: ");
            io:println(add(firstNumber, secondNumber));
        } else if(operation == 2) {
            io:print("Subtract result: ");
            io:println(subtract(firstNumber, secondNumber));
        } else {
            io:println("Invalid choice");
        }
    }
    io:println("break");
}
