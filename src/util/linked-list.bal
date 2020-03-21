import ballerina/io;

public type Node record {|
    any value;
    Node? prev = ();
    Node? next = ();
|};

public type LinkedList record {
    Node? head;
    Node? tail;
};

public function addLast(LinkedList list, Node node) {
    if (list.tail is ()) {
        list.head = node;
        list.tail = list.head;
        return;
    }

    Node tailNode = <Node>list.tail;
    node.prev = tailNode;
    tailNode.next = node;
    list.tail = node;
}

public function addFirst(LinkedList list, Node node) {
    if (list.head is ()) {
        list.head = node;
        list.tail = list.head;
        return;
    }

    Node headNode = <Node>list.head;
    node.next = headNode;
    headNode.prev = node;
    list.head = node;
}

public function remove(LinkedList list, Node node) {
    if (node.prev is ()) {
        list.head = node.next;
    } else {
        Node prev = <Node>node.prev;
        prev.next = node.next;
    }

    if (node.next is ()) {
        list.tail = node.prev;
    } else {
        Node next = <Node>node.next;
        next.prev = node.prev;
    }
    node.next = ();
    node.prev = ();
}

public function removeLast(LinkedList list) returns Node? {
    if (list.tail is ()) {
        return ();
    }
    Node tail = <Node>list.tail;
    Node predecessorOfTail = <Node>tail.prev;
    list.tail = predecessorOfTail;
    predecessorOfTail.next = ();
    tail.prev = ();

    return tail;
}

public function clear(LinkedList list) {
    list.head = ();
    list.tail = ();
}

// For debug process
public function print(LinkedList list) {
    if (list.head is ()) {
        io:println("List is empty ...");
        return;
    }

    Node head = <Node>list.head;
    io:println("--------------------------------------------------");
    io:println("HEAD: " + head.value.toString());
    Node? prevOfHead = head.prev;
    io:println(prevOfHead is () ? "head.prev is ()" : "head.prev -> Ooops!");

    Node? next = list.head;
    while (!(next is ())) {
        io:println(next.value);
        next = next.next;
    }

    Node tail = <Node>list.tail;
    io:println("TAIL: " + tail.value.toString());
    Node? nextOfTail = tail.next;
    io:println(nextOfTail is () ? "tail.next is ()" : "tail.next -> Ooops!");
    io:println("--------------------------------------------------");
}
