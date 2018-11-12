import ballerina/io;

public function main(string... args) {

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
        }

        // Read two numbers from user to be used for calculator operations
        var input1 = io:readln("Enter first number: ");
        float firstNumber = check <float>input1;
        var input2 = io:readln("Enter second number: ");
        float secondNumber = check <float>input2;

        // Execute calculator operations based on user's choice
        if (operation == 1) {
            io:print("Add result: ");
            io:println(add(firstNumber, secondNumber));
        } else if (operation == 2) {
            io:print("Subtract result: ");
            io:println(subtract(firstNumber, secondNumber));
        } else {
            io:println("Invalid choice");
        }
    }
    io:println("break");
}
