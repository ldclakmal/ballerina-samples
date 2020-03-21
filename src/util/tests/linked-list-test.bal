import ballerina/test;

@test:Config {}
function test() {
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

    print(list);
}
