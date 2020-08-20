import ballerina/test;

@test:Config {}
function testCachePerformance() {
    evaluatePerformance(10);
    evaluatePerformance(100);
    evaluatePerformance(1000);
    evaluatePerformance(10000);
    evaluatePerformance(100000);
}
