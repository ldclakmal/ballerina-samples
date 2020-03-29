# The element which contains the value and references for the linkage.
#
# + value - The value of the element
# + prev - Previous `Node` of the list
# + next - Next `Node` of the list
public type Node record {|
    any value;
    Node? prev = ();
    Node? next = ();
|};

# Doubly linked list implementation with all the operations. Operations that index into the list will traverse the list
# from the beginning or the end, whichever is closer to the specified index.
# Note that this implementation is not synchronized. If multiple threads access a linked list concurrently, and at least
# one of the threads modifies the list structurally, it must be synchronized externally.
public type LinkedList object {

    Node? head;
    Node? tail;
    int size;

    public function __init() {
        self.head = ();
        self.tail = ();
        self.size = 0;
    }

    # Returns the first element in this list.
    #
    # + return - `Node` which is at the head of the list, of `()` if the list is empty
    public function getFirst() returns Node? {
        if (self.head is ()) {
            return;
        }
        return self.head;
    }

    # Returns the last element in this list.
    #
    # + return - `Node` which is at the tail of the list, of `()` if the list is empty
    public function getLast() returns Node? {
        if (self.tail is ()) {
            return;
        }
        return self.tail;
    }

    # Inserts the specified element at the beginning of this list.
    #
    # + node - `Node` to be inserted
    public function addFirst(Node node) {
        if (self.head is ()) {
            self.head = node;
            self.tail = self.head;
            self.size = self.size + 1;
            return;
        }

        Node headNode = <Node>self.head;
        node.next = headNode;
        headNode.prev = node;
        self.head = node;
        self.size = self.size + 1;
    }

    # Appends the specified element to the end of this list.
    #
    # + node - `Node` to be inserted
    public function addLast(Node node) {
        if (self.tail is ()) {
            self.head = node;
            self.tail = self.head;
            self.size = self.size + 1;
            return;
        }

        Node tailNode = <Node>self.tail;
        node.prev = tailNode;
        tailNode.next = node;
        self.tail = node;
        self.size = self.size + 1;
    }

    # Removes and returns the first element from this list.
    #
    # + return - `Node` which is the first element or `()` if the list is empty
    public function removeFirst() returns Node? {
        if (self.head is ()) {
            return ();
        }
        Node head = <Node>self.head;
        Node successorOfHead = <Node>head.next;
        self.head = successorOfHead;
        successorOfHead.prev = ();
        head.next = ();
        self.size = self.size - 1;

        return head;
    }

    # Removes and returns the last element from this list.
    #
    # + return - `Node` which is the last element or `()` if the list is empty
    public function removeLast() returns Node? {
        if (self.tail is ()) {
            return ();
        }
        Node tail = <Node>self.tail;
        Node predecessorOfTail = <Node>tail.prev;
        self.tail = predecessorOfTail;
        predecessorOfTail.next = ();
        tail.prev = ();
        self.size = self.size - 1;

        return tail;
    }

    # Removes the specified element from this list. It should be a `Node` which is retrieved from the list.
    #
    # + node - `Node` to be removed
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
        self.size = self.size - 1;
    }

    public function size() returns int {
        return self.size;
    }

    # Removes all of the elements from this list.
    public function clear() {
        self.head = ();
        self.tail = ();
        self.size = 0;
    }

    # Prints the complete linked list with head and tail in following pattern.
    # '[HEAD] 6 -> 2 -> 1 -> 4 -> 5 [TAIL]'
    #
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
