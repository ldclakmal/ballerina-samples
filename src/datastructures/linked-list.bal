// The internal element which contains the value and references for the linkage.
type Node record {|
    anydata value;
    Node? prev = ();
    Node? next = ();
|};

// TODO: Prevent inserting the `()` as the value.

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
    # + return - Value of the head of the list, of `()` if the list is empty
    public function getFirst() returns anydata {
        if (self.head is ()) {
            return;
        }
        Node head = <Node>self.head;
        return head.value;
    }

    # Returns the last element in this list.
    #
    # + return - Value of the tail of the list, of `()` if the list is empty
    public function getLast() returns anydata {
        if (self.tail is ()) {
            return;
        }
        Node tail = <Node>self.tail;
        return tail.value;
    }

    # Return the element at the specified index, if index is valid.
    #
    # + index - Index of the list, starting from 0
    # + return - Value of the element or `()` if the list is empty or index is invalid
    public function getByIndex(int index) returns anydata {
        if (index < 0 || index >= self.size) {
            return;
        }

        if (index < self.size / 2) {
            int count = 0;
            Node node = <Node>self.head;
            while (count != index) {
                if (node.next is ()) {
                    return;
                }
                node = <Node>node.next;
                count = count + 1;
            }
            return node.value;
        } else {
            int count = self.size - 1;
            Node node = <Node>self.tail;
            while (count != index) {
                if (node.prev is ()) {
                    return;
                }
                node = <Node>node.prev;
                count = count - 1;
            }
            return node.value;
        }
    }

    # Inserts the specified element at the beginning of this list.
    #
    # + value - Value to be inserted
    public function addFirst(anydata value) {
        Node node = {value: value};
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
    # + value - Value to be inserted
    public function addLast(anydata value) {
        Node node = {value: value};
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

    # Appends the specified element to the specified index of the list.
    #
    # + value - Value to be inserted
    # + index - Index of the list, starting from 0
    public function addByIndex(anydata value, int index) {
        if (index < 0 || index >= self.size) {
            return;
        }

        if (index < self.size / 2) {
            int count = 0;
            Node node = <Node>self.head;
            while (count != index) {
                if (node.next is ()) {
                    return;
                }
                node = <Node>node.next;
                count = count + 1;
            }
            Node newNode = {value: value};
            Node? prev = node.prev;
            newNode.next = node;
            newNode.prev = prev;
            if !(prev is ()) {
                prev.next = newNode;
            }
            node.prev = newNode;
        } else {
            int count = self.size - 1;
            Node node = <Node>self.tail;
            while (count != index) {
                if (node.prev is ()) {
                    return;
                }
                node = <Node>node.prev;
                count = count - 1;
            }
            Node newNode = {value: value};
            Node? prev = node.prev;
            newNode.next = node;
            newNode.prev = prev;
            if !(prev is ()) {
                prev.next = newNode;
            }
            node.prev = newNode;
        }
        self.size = self.size + 1;
    }

    # Removes and returns the first element from this list.
    #
    # + return - Value of the first element or `()` if the list is empty
    public function removeFirst() returns anydata {
        if (self.head is ()) {
            return ();
        }
        Node head = <Node>self.head;
        Node successorOfHead = <Node>head.next;
        self.head = successorOfHead;
        successorOfHead.prev = ();
        head.next = ();
        self.size = self.size - 1;

        return head.value;
    }

    # Removes and returns the last element from this list.
    #
    # + return - Value of the last element or `()` if the list is empty
    public function removeLast() returns anydata {
        if (self.tail is ()) {
            return ();
        }
        Node tail = <Node>self.tail;
        Node predecessorOfTail = <Node>tail.prev;
        self.tail = predecessorOfTail;
        predecessorOfTail.next = ();
        tail.prev = ();
        self.size = self.size - 1;

        return tail.value;
    }

    # Removes the specified element from this list, if it is present.
    #
    # + value - Value to be removed
    public function remove(anydata value) {
        if (self.head is ()) {
            return;
        }

        Node node = <Node>self.head;
        while (node.value != value) {
            if (node.next is ()) {
                return;
            }
            node = <Node>node.next;
        }
        self.removeNode(node);
    }

    # Removes the element at the specified index from this list, if index is valid.
    #
    # + index - Index of the list, starting from 0
    # + return - Value of the removed element or `()` if the list is empty or index is invalid
    public function removeByIndex(int index) returns anydata {
        if (index < 0 || index >= self.size) {
            return;
        }

        if (index < self.size / 2) {
            int count = 0;
            Node node = <Node>self.head;
            while (count != index) {
                if (node.next is ()) {
                    return;
                }
                node = <Node>node.next;
                count = count + 1;
            }
            self.removeNode(node);
            return node.value;
        } else {
            int count = self.size - 1;
            Node node = <Node>self.tail;
            while (count != index) {
                if (node.prev is ()) {
                    return;
                }
                node = <Node>node.prev;
                count = count - 1;
            }
            self.removeNode(node);
            return node.value;
        }
    }

    private function removeNode(Node node) {
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

    # Returns true if this list contains the specified element.
    #
    # + value - Value to be checked for
    # + return - `true` if the list contains the specified, `false` otherwise
    public function contains(anydata value) returns boolean {
        if (self.head is ()) {
            return false;
        }

        Node node = <Node>self.head;
        while (node.value != value) {
            if (node.next is ()) {
                return false;
            }
            node = <Node>node.next;
        }
        return true;
    }

    # Return the size (no of elements) of the list.
    #
    # + return - The size of the list
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
