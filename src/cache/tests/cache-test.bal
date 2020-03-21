import ballerina/cache;
import ballerina/runtime;
import ballerina/test;

@test:Config {}
function testCacheEvictionWithCapacity1() {
    cache:CacheConfig config = {
        capacity: 10,
        evictionFactor: 0.2
    };
    cache:Cache cache = new(config);
    checkpanic cache.put("A", "1");
    checkpanic cache.put("B", "2");
    checkpanic cache.put("C", "3");
    checkpanic cache.put("D", "4");
    checkpanic cache.put("E", "5");
    checkpanic cache.put("F", "6");
    checkpanic cache.put("G", "7");
    checkpanic cache.put("H", "8");
    checkpanic cache.put("I", "9");
    checkpanic cache.put("J", "10");
    checkpanic cache.put("K", "11");
    int size = cache.size();
    test:assertEquals(size, 9);
    string[] keys = cache.keys();
    var expected = ["C", "D", "E", "F", "G", "H", "I", "J", "K"];
    test:assertEquals(keys, expected);
}

@test:Config {}
function testCacheEvictionWithCapacity2() {
    cache:CacheConfig config = {
        capacity: 10,
        evictionFactor: 0.2
    };
    cache:Cache cache = new(config);
    checkpanic cache.put("A", "1");
    checkpanic cache.put("B", "2");
    checkpanic cache.put("C", "3");
    checkpanic cache.put("D", "4");
    checkpanic cache.put("E", "5");
    checkpanic cache.put("F", "6");
    checkpanic cache.put("G", "7");
    checkpanic cache.put("H", "8");
    checkpanic cache.put("I", "9");
    checkpanic cache.put("J", "10");
    any|cache:Error x = cache.get("A");
    checkpanic cache.put("K", "11");
    int size = cache.size();
    test:assertEquals(size, 9);
    string[] keys = cache.keys();
    var expected = ["A", "D", "E", "F", "G", "H", "I", "J", "K"];
    test:assertEquals(keys, expected);
}

@test:Config {}
function testCacheEvictionWithTimer1() {
    int cleanupIntervalInSeconds = 2;
    cache:CacheConfig config = {
        capacity: 10,
        evictionFactor: 0.2,
        defaultMaxAgeInSeconds: 1,
        cleanupIntervalInSeconds: cleanupIntervalInSeconds
    };
    cache:Cache cache = new(config);
    checkpanic cache.put("A", "1");
    checkpanic cache.put("B", "2");
    checkpanic cache.put("C", "3");
    runtime:sleep(cleanupIntervalInSeconds * 1000 * 2 + 1000);
    int size = cache.size();
    test:assertEquals(size, 0);
    string[] keys = cache.keys();
    var expected = [];
    test:assertEquals(keys, expected);
}

@test:Config {}
function testCacheEvictionWithTimer2() {
    int cleanupIntervalInSeconds = 2;
    cache:CacheConfig config = {
        capacity: 10,
        evictionFactor: 0.2,
        defaultMaxAgeInSeconds: 1,
        cleanupIntervalInSeconds: cleanupIntervalInSeconds
    };
    cache:Cache cache = new(config);
    checkpanic cache.put("A", "1");
    checkpanic cache.put("B", "2", 3600);
    checkpanic cache.put("C", "3");
    runtime:sleep(cleanupIntervalInSeconds * 1000 * 2 + 1000);
    int size = cache.size();
    test:assertEquals(size, 1);
    string[] keys = cache.keys();
    var expected = ["B"];
    test:assertEquals(keys, expected);
}

@test:Config {
    dependsOn: ["testCacheEvictionWithCapacity1", "testCacheEvictionWithCapacity2",
    "testCacheEvictionWithTimer1", "testCacheEvictionWithTimer2"]
}
function testCachePerformance() {
    evaluatePerformance(10);
    evaluatePerformance(100);
    evaluatePerformance(1000);
    evaluatePerformance(10000);
    evaluatePerformance(100000);
}
