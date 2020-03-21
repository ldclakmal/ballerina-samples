import ballerina/cache;
import ballerina/io;
import ballerina/runtime;
import ballerina/test;

@test:Config {}
function test() returns error? {
  cache:CacheConfig config = {
    capacity: 10,
    evictionFactor: 0.2,
    cleanupIntervalInSeconds: 15
  };
  cache:Cache c = new(config);

  _ = check c.put("key 1", "value 1");
  _ = check c.put("key 2", "value 2");
  _ = check c.put("key 3", "value 3", 2);
  _ = check c.put("key 4", "value 4");
  _ = check c.put("key 5", "value 5");
  _ = check c.put("key 6", "value 6");
  _ = check c.put("key 7", "value 7");
  _ = check c.put("key 8", "value 8");
  _ = check c.put("key 9", "value 9");
  _ = check c.put("key 10", "value 10");
  io:println(c.size());

  // c.put("key 11", "value 11");
  // io:println(c.size());

  any a = check c.get("key 3");
  io:println(c.size());

  // c.remove("key 5");
  // io:println(c.size());

  string[] keys = c.keys();
  io:println(keys);

  runtime:sleep(10000);

  // a = c.get("key 3");
  // io:println(c.size());

  keys = c.keys();
  io:println(keys);
}
