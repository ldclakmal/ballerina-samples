import ballerina/test;

@test:Config {}
function testLinkedListForEmptyNodes() {
    LinkedList list = new;
    string actual = list.print();
    string expected = "List is empty.";
    test:assertEquals(actual, expected);
}

@test:Config {
    dependsOn: ["testLinkedListForEmptyNodes"]
}
function testLinkedListForOneNode() {
    LinkedList list = new;
    Node node1 = {value: 10};
    list.addFirst(node1);
    string actual = list.print();
    string expected = "[HEAD] 10 [TAIL]";
    test:assertEquals(actual, expected);
}

@test:Config {
    dependsOn: ["testLinkedListForOneNode"]
}
function testLinkedListForMultipleNodes() {
    LinkedList list = new;
    Node node1 = {value: 1};
    Node node2 = {value: 2};
    Node node3 = {value: 3};
    Node node4 = {value: 4};
    Node node5 = {value: 5};
    Node node6 = {value: 6};
    Node node7 = {value: 7};
    list.addFirst(node1);
    list.addFirst(node2);
    list.addFirst(node3);
    list.addFirst(node4);
    list.addFirst(node5);
    list.addFirst(node6);
    list.addFirst(node7);

    string actual = list.print();
    string expected = "[HEAD] 7 -> 6 -> 5 -> 4 -> 3 -> 2 -> 1 [TAIL]";
    test:assertEquals(actual, expected);
}

@test:Config {
    dependsOn: ["testLinkedListForMultipleNodes"]
}
function testLinkedListForAllOperations() {
    LinkedList list = new;
    Node node1 = {value: 1};
    Node node2 = {value: 2};
    Node node3 = {value: 3};
    Node node4 = {value: 4};
    Node node5 = {value: 5};
    Node node6 = {value: 6};
    Node node7 = {value: 7};
    list.addFirst(node1);
    list.addFirst(node2);
    list.addFirst(node3);
    _ = list.removeLast();
    list.addLast(node4);
    list.addLast(node5);
    _ = list.removeFirst();
    list.addFirst(node6);
    list.addLast(node7);
    list.remove(node5);

    string actual = list.print();
    string expected = "[HEAD] 6 -> 2 -> 4 -> 7 [TAIL]";
    test:assertEquals(actual, expected);
}
