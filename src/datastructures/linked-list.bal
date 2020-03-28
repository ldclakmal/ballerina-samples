public type Node record {|
    any value;
    Node? prev = ();
    Node? next = ();
|};

public type LinkedList object {

    Node? head;
    Node? tail;

    public function __init() {
        self.head = ();
        self.tail = ();
    }

    public function addFirst(Node node) {
        if (self.head is ()) {
            self.head = node;
            self.tail = self.head;
            return;
        }

        Node headNode = <Node>self.head;
        node.next = headNode;
        headNode.prev = node;
        self.head = node;
    }

    public function addLast(Node node) {
        if (self.tail is ()) {
            self.head = node;
            self.tail = self.head;
            return;
        }

        Node tailNode = <Node>self.tail;
        node.prev = tailNode;
        tailNode.next = node;
        self.tail = node;
    }

    public function removeFirst() returns Node? {
        if (self.head is ()) {
            return ();
        }
        Node head = <Node>self.head;
        Node successorOfHead = <Node>head.next;
        self.head = successorOfHead;
        successorOfHead.prev = ();
        head.next = ();

        return head;
    }

    public function removeLast() returns Node? {
        if (self.tail is ()) {
            return ();
        }
        Node tail = <Node>self.tail;
        Node predecessorOfTail = <Node>tail.prev;
        self.tail = predecessorOfTail;
        predecessorOfTail.next = ();
        tail.prev = ();

        return tail;
    }

    public function remove(Node node) {
        if (node.prev is ()) {
            self.head = node.next;
        } else {
            Node prev = <Node>node.prev;
            prev.next = node.next;
        }

        if (node.next is ()) {
            self.tail = node.prev;
        } else {
            Node next = <Node>node.next;
            next.prev = node.prev;
        }
        node.next = ();
        node.prev = ();
    }

    public function clear() {
        self.head = ();
        self.tail = ();
    }

    # Prints the complete linked list with head and tail in following pattern.
    # '[HEAD] 6 -> 2 -> 1 -> 4 -> 5 [TAIL]'
    #
    # + list - The linked list to print
    # + return - The string representation of the complete linked list
    public function print() returns string {
        if (self.head is ()) {
            return "List is empty.";
        }

        Node head = <Node>self.head;
        Node tail = <Node>self.tail;

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
        Node next = <Node>self.head;
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

};
