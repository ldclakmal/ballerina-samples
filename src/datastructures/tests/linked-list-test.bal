import ballerina/test;

@test:Config {}
function testEmptyLinkedList() {
    LinkedList list = new;
    string actual = list.print();
    string expected = "List is empty.";
    test:assertEquals(actual, expected);
    test:assertEquals(list.size(), 0);
}

@test:Config {
    dependsOn: ["testEmptyLinkedList"]
}
function testLinkedListForOneElement() {
    LinkedList list = new;
    list.addFirst(10);
    string actual = list.print();
    string expected = "[HEAD] 10 [TAIL]";
    test:assertEquals(actual, expected);
    test:assertEquals(list.size(), 1);
}

@test:Config {
    dependsOn: ["testLinkedListForOneElement"]
}
function testLinkedListForMultipleElements() {
    LinkedList list = new;
    list.addFirst(1);
    list.addFirst(2);
    list.addFirst(3);
    list.addFirst(4);
    list.addFirst(5);
    list.addFirst(6);
    list.addFirst(7);

    string actual = list.print();
    string expected = "[HEAD] 7 -> 6 -> 5 -> 4 -> 3 -> 2 -> 1 [TAIL]";
    test:assertEquals(actual, expected);
    test:assertEquals(list.size(), 7);
}

@test:Config {
    dependsOn: ["testLinkedListForMultipleElements"]
}
function testLinkedListForAllOperations() {
    LinkedList list = new;
    list.addFirst(1);
    list.addFirst(2);
    list.addFirst(3);
    int last = <int>list.removeLast();
    test:assertEquals(last, 1);
    list.addLast(4);
    list.addLast(5);
    int first = <int>list.removeFirst();
    test:assertEquals(first, 3);
    list.addFirst(6);
    list.addLast(7);
    list.remove(5);
    first = <int>list.getFirst();
    test:assertEquals(first, 6);
    last = <int>list.getLast();
    test:assertEquals(last, 7);
    boolean contains = list.contains(7);
    test:assertTrue(contains);
    contains = list.contains(1);
    test:assertFalse(contains);
    int get = <int>list.getByIndex(2);
    test:assertEquals(get, 4);
    list.addByIndex(10, 2);
    int remove = <int>list.removeByIndex(2);
    test:assertEquals(remove, 10);

    string actual = list.print();
    string expected = "[HEAD] 6 -> 2 -> 4 -> 7 [TAIL]";
    test:assertEquals(actual, expected);
    test:assertEquals(list.size(), 4);
}
