import ballerina/test;

@test:Config {}
function testLinkedListForEmptyNodes() {
    LinkedList list = {head: (), tail: ()};
    string actual = print(list);
    string expected = "List is empty.";
    test:assertEquals(actual, expected);
}

@test:Config {
    dependsOn: ["testLinkedListForEmptyNodes"]
}
function testLinkedListForOneNode() {
    LinkedList list = {head: (), tail: ()};
    Node node1 = {value: 10};
    addFirst(list, node1);
    string actual = print(list);
    string expected = "[HEAD] 10 [TAIL]";
    test:assertEquals(actual, expected);
}

@test:Config {
    dependsOn: ["testLinkedListForOneNode"]
}
function testLinkedListForMultipleNodes() {
    LinkedList list = {head: (), tail: ()};
    Node node1 = {value: 1};
    Node node2 = {value: 2};
    Node node3 = {value: 3};
    Node node4 = {value: 4};
    Node node5 = {value: 5};
    Node node6 = {value: 6};
    Node node7 = {value: 7};
    addFirst(list, node1);
    addFirst(list, node2);
    addFirst(list, node3);
    addFirst(list, node4);
    addFirst(list, node5);
    addFirst(list, node6);
    addFirst(list, node7);

    string actual = print(list);
    string expected = "[HEAD] 7 -> 6 -> 5 -> 4 -> 3 -> 2 -> 1 [TAIL]";
    test:assertEquals(actual, expected);
}

@test:Config {
    dependsOn: ["testLinkedListForMultipleNodes"]
}
function testLinkedListForAllOperations() {
    LinkedList list = {head: (), tail: ()};
    Node node1 = {value: 1};
    Node node2 = {value: 2};
    Node node3 = {value: 3};
    Node node4 = {value: 4};
    Node node5 = {value: 5};
    Node node6 = {value: 6};
    Node node7 = {value: 7};
    addFirst(list, node1);
    addFirst(list, node2);
    addFirst(list, node3);
    addLast(list, node4);
    addLast(list, node5);
    addFirst(list, node6);
    addLast(list, node7);
    _ = removeLast(list);
    remove(list, node3);

    string actual = print(list);
    string expected = "[HEAD] 6 -> 2 -> 1 -> 4 -> 5 [TAIL]";
    test:assertEquals(actual, expected);
}
