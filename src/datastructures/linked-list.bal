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

# Prints the complete linked list with head and tail in following pattern.
# '[HEAD] 6 -> 2 -> 1 -> 4 -> 5 [TAIL]'
#
# + list - The linked list to print
# + return - The string representation of the complete linked list
public function print(LinkedList list) returns string {
    if (list.head is ()) {
        return "List is empty.";
    }

    Node head = <Node>list.head;
    Node tail = <Node>list.tail;

    Node? prevOfHead = head.prev;
    if !(prevOfHead is ()) {
        return "head.prev is not empty. Something went wrong!";
    }

    Node? nextOfTail = tail.next;
    if !(nextOfTail is ()) {
        return "tail.next is not empty. Something went wrong!";
    }

    string s = "[HEAD] " + head.value.toString();
    if (head !== tail) {
        s += " -> ";
    }
    Node next = <Node>list.head;
    while (true) {
        if (next === head || next === tail) {
            if (next.next is ()) {
                break;
            }
            next = <Node>next.next;
            continue;
        }

        s += next.value.toString();
        if (next.next is ()) {
            break;
        }
        next = <Node>next.next;
        s += " -> ";
    }
    if (head !== tail) {
        s += tail.value.toString();
    }
    s += " [TAIL]";

    return s;
}
