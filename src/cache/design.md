# Design 1

## Abstract Objects

```ballerina
public type AbstractEvictionPolicy abstract object {
    public function get(LinkedList list, Node node);
    public function put(LinkedList list, Node node);
};

public type AbstractCache abstract object {
    public function put(string key, any value);
    public function get(string key) returns any|Error;
};
```

## Implementation

```ballerina
public type LruEvictionPolicy object {
    // ...
};


public type CacheConfig record {
    int capacity = 100;
    float evictionFactor = 0.25;
    // ...
    AbstractEvictionPolicy ep = new LruEvictionPolicy();
};

public type CacheEntry record {
    string key;
    string value;
    int exp;
};

public type Cache object {
    
    *AbstractCache;

    map<Node> m = {};
    int capacity;
    LinkedList list;
    AbstractEvictionPolicy ep;
    
    public function __init(CacheConfig config = {}) {
        self.capacity = config.capacity;
        self.list = {
            head: (),
            tail: ()
        };
        self.ep = config.ep;
    }

    public function put(string key, any value) {
        CacheEntry entry = {
            key: key,
            value: value,
            exp: -1
        };
        Node node = {
            value: entry
        };
        self.m[key] = node;
        self.ep.put(self.list, node);
    }

    public function get(string key) returns any|Error {
        Node node = self.m.get(key);
        CacheEntry entry = <CacheEntry>node.value;
        // validate entry value
        return entry.value;
    }
};
```

## Samples

### Sample 1 - Simple initialization

```ballerina
cache:Cache c = new;
// cache:AbstractCache c = new Cache();
```

### Sample 2 - Advanced initialization

```ballerina
cache:Cache c = new({
    capacity: 1000,
    ep: customEvictionPolicy
});

// OR

cache:AbstractCache c = new Cache({
   capacity: 1000,
   ep: customEvictionPolicy
});
```

### Sample 3 - Usage in another module

```ballerina
public type JwtConfig record {
    string issuer;
    // ...
    cache:Cache jwtCache;
};

// OR

public type JwtConfig record {
   string issuer;
   // ...
   cache:AbstractCache jwtCache;
};
```

---

# Design 2

## Abstract Objects

```ballerina
public type AbstractEvictionPolicy abstract object {
    public function get(LinkedList list, Node node);
    public function put(LinkedList list, Node node);
};

public type AbstractDataSource abstract object {
    public function put(string key, any value) returns Node;
    public function get(string key) returns [any, Node];
};
```

## Implementation

```ballerina
public type LruEvictionPolicy object {
    // ...
};

public type CacheConfig record {
    AbstractDataSource ds = new MapDataSource();
    AbstractEvictionPolicy ep = new LruEvictionPolicy();
};

public type Cache object {

    AbstractDataSource ds;
    AbstractEvictionPolicy ep;
    LinkedList list;

    public function __init(CacheConfig config = {}) {
        self.ds = config.ds;
        self.ep = config.ep;
        self.list = {
            head: (),
            tail: ()
        };
    }

    public function put(string key, any value) {
        Node node = self.ds.put(key, value);
        self.ep.put(self.list, node);
    }

    public function get(string key) returns any|Error {
        [any|Error, Node] [result, node] = self.ds.get(key);
        self.ep.get(self.list, node);
        return result;
    }
};

public type MapCacheConfig record {
    int capacity = 100;
    float evictionFactor = 0.25;
    // ...
};

public type MapDataSource object {
    
    *AbstractDataSource;

    map<Node> m = {};
    int capacity;
    
    public function __init(MapCacheConfig config = {}) {
        self.capacity = config.capacity;
    }

    public function put(string key, any value) returns Node {
        Node node = {
            value: value
        };
        self.m[key] = node;
        return node;
    }

    public function get(string key) returns [any|Error, Node] {
        Node node = self.m.get(key);
        // validate node value
        return [node.value, node];
    }
};
```

## Samples

### Sample 1 - Simple initialization

```ballerina
cache:Cache c = new;
```

### Sample 1 - Advanced initialization

```ballerina
MapDataSource mds = new({
    capacity: 1000,
    evictionFactor: 0.2
});

cache:Cache c = new({
    ep: customEvictionPolicy,
    ds: mds
});
```

### Sample 3 - Usage in another module

```ballerina
public type JwtConfig record {
    string issuer;
    // ...
    cache:Cache jwtCache;
};
```
