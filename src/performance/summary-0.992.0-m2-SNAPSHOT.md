# Ballerina Performance Test Results

During each release, we execute various automated performance test scenarios and publish the results.

| Test Scenarios | Description |
| --- | --- |
| Passthrough HTTP service (h1c -> h1c) | An HTTP Service, which forwards all requests to an HTTP back-end service. |
| Passthrough HTTPS service (h1 -> h1) | An HTTPS Service, which forwards all requests to an HTTPS back-end service. |
| Passthrough HTTP/2(over TLS) service (h2 -> h2) | An HTTPS Service exposed over HTTP/2 protocol, which forwards all requests to an HTTP/2(over TLS) back-end service. |
| Passthrough HTTP/2(over TLS) service (h2 -> h1) | An HTTPS Service exposed over HTTP/2 protocol, which forwards all requests to an HTTPS back-end service. |
| Passthrough HTTP/2(over TLS) service (h2 -> h1c) | An HTTPS Service exposed over HTTP/2 protocol, which forwards all requests to an HTTP back-end service. |
| HTTP/2 client and server downgrade service (h2 -> h2) | An HTTP/2(with TLS) server accepts requests from an HTTP/1.1(with TLS) client and the HTTP/2(with TLS) client sends requests to an HTTP/1.1(with TLS) back-end service. Both the upstream and the downgrade connection is downgraded to HTTP/1.1(with TLS). |

Our test client is [Apache JMeter](https://jmeter.apache.org/index.html). We test each scenario for a fixed duration of
time. We split the test results into warmup and measurement parts and use the measurement part to compute the
performance metrics.

A majority of test scenarios use a [Netty](https://netty.io/) based back-end service which echoes back any request
posted to it after a specified period of time.

We run the performance tests under different numbers of concurrent users, message sizes (payloads) and back-end service
delays.

The main performance metrics:

1. **Throughput**: The number of requests that the Ballerina service processes during a specific time interval (e.g. per second).
2. **Response Time**: The end-to-end latency for an operation of invoking a Ballerina service. The complete distribution of response times was recorded.

In addition to the above metrics, we measure the load average and several memory-related metrics.

The following are the test parameters.

| Test Parameter | Description | Values |
| --- | --- | --- |
| Scenario Name | The name of the test scenario. | Refer to the above table. |
| Heap Size | The amount of memory allocated to the application | 2G |
| Concurrent Users | The number of users accessing the application at the same time. | 100, 300, 1000 |
| Message Size (Bytes) | The request payload size in Bytes. | 50, 1024 |
| Back-end Delay (ms) | The delay added by the back-end service. | 0 |

The duration of each test is **900 seconds**. The warm-up period is **300 seconds**.
The measurement results are collected after the warm-up period.

A [**c5.xlarge** Amazon EC2 instance](https://aws.amazon.com/ec2/instance-types/) was used to install Ballerina.

The following are the measurements collected from each performance test conducted for a given combination of
test parameters.

| Measurement | Description |
| --- | --- |
| Error % | Percentage of requests with errors |
| Average Response Time (ms) | The average response time of a set of results |
| Standard Deviation of Response Time (ms) | The “Standard Deviation” of the response time. |
| 99th Percentile of Response Time (ms) | 99% of the requests took no more than this time. The remaining samples took at least as long as this |
| Throughput (Requests/sec) | The throughput measured in requests per second. |
| Average Memory Footprint After Full GC (M) | The average memory consumed by the application after a full garbage collection event. |

The following is the summary of performance test results collected for the measurement period.

|  Scenario Name | Concurrent Users | Message Size (Bytes) | Back-end Service Delay (ms) | Error % | Throughput (Requests/sec) | Average Response Time (ms) | Standard Deviation of Response Time (ms) | 99th Percentile of Response Time (ms) | Ballerina GC Throughput (%) | Average Ballerina Memory Footprint After Full GC (M) |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|  Passthrough HTTP service (h1c -> h1c) | 100 | 50 | 0 | 0 | 19488.43 | 5.09 | 6.06 | 34 | 99.41 | 16.502 |
|  Passthrough HTTP service (h1c -> h1c) | 100 | 1024 | 0 | 0 | 17841.56 | 5.56 | 6.88 | 41 | 99.3 | 18.854 |
|  Passthrough HTTP service (h1c -> h1c) | 300 | 50 | 0 | 0 | 20867.62 | 14.33 | 12 | 72 | 98.79 | 21.061 |
|  Passthrough HTTP service (h1c -> h1c) | 300 | 1024 | 0 | 0 | 19282.97 | 15.5 | 12.13 | 71 | 98.8 | 17.036 |
|  Passthrough HTTP service (h1c -> h1c) | 1000 | 50 | 0 | 0 | 19208.34 | 51.99 | 26.63 | 156 | 96.61 | 17.416 |
|  Passthrough HTTP service (h1c -> h1c) | 1000 | 1024 | 0 | 0 | 18515.58 | 53.93 | 26.41 | 158 | 96.73 | 17.447 |
|  Passthrough HTTPS service (h1 -> h1) | 100 | 50 | 0 | 0 | 16952.84 | 5.86 | 6.9 | 31 | 99.47 | 23.097 |
|  Passthrough HTTPS service (h1 -> h1) | 100 | 1024 | 0 | 0 | 11787.86 | 8.43 | 6.34 | 29 | 99.53 | 23.13 |
|  Passthrough HTTPS service (h1 -> h1) | 300 | 50 | 0 | 0 | 17252.51 | 17.33 | 12.73 | 70 | 98.87 | 23.232 |
|  Passthrough HTTPS service (h1 -> h1) | 300 | 1024 | 0 | 0 | 12015.4 | 24.91 | 11.7 | 62 | 99.08 | 23.288 |
|  Passthrough HTTPS service (h1 -> h1) | 1000 | 50 | 0 | 0 | 15347.73 | 65.08 | 29.68 | 164 | 96.96 | 24.696 |
|  Passthrough HTTPS service (h1 -> h1) | 1000 | 1024 | 0 | 0 | 11434.04 | 87.36 | 29.26 | 171 | 97.41 | 24.693 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h1c) | 100 | 50 | 0 | 0 | 15915.98 | 6.12 | 7.82 | 45 | 99.5 | 24.081 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h1c) | 100 | 1024 | 0 | 0 | 15338.67 | 6.26 | 8.2 | 44 | 99.52 | 24.084 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h1c) | 300 | 50 | 0 | 0 | 16273.36 | 18.04 | 13.85 | 77 | 98.9 | 24.305 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h1c) | 300 | 1024 | 0 | 0 | 15588.74 | 18.44 | 13.99 | 77 | 98.94 | 24.529 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h1c) | 1000 | 50 | 0 | 0 | 14944.12 | 66.17 | 29.38 | 167 | 96.75 | 25.162 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h1c) | 1000 | 1024 | 0 | 0 | 14730.36 | 66.88 | 30.88 | 173 | 96.85 | 25.206 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h1) | 100 | 50 | 0 | 0 | 14559.78 | 6.71 | 6.55 | 30 | 99.46 | 24.031 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h1) | 100 | 1024 | 0 | 0 | 11830.56 | 8.23 | 6.08 | 29 | 99.54 | 24.093 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h1) | 300 | 50 | 0 | 0 | 14766.82 | 19.95 | 12.81 | 69 | 98.87 | 24.523 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h1) | 300 | 1024 | 0 | 0 | 11842.26 | 24.72 | 12.03 | 63 | 98.96 | 24.321 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h1) | 1000 | 50 | 0 | 0 | 13377.42 | 74.16 | 30.77 | 174 | 96.74 | 25.184 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h1) | 1000 | 1024 | 0 | 0 | 11196.46 | 88.55 | 31.75 | 183 | 96.98 | 25.199 |
|  HTTP/2 client and server downgrade service (h2 -> h2) | 100 | 50 | 0 | 0 | 18000.49 | 5.51 | 7.93 | 44 | 99.5 | 23.901 |
|  HTTP/2 client and server downgrade service (h2 -> h2) | 100 | 1024 | 0 | 0 | 15643.15 | 6.35 | 7.07 | 32 | 99.57 | 23.906 |
|  HTTP/2 client and server downgrade service (h2 -> h2) | 300 | 50 | 0 | 0 | 18017.57 | 16.6 | 13.54 | 76 | 98.96 | 24.12 |
|  HTTP/2 client and server downgrade service (h2 -> h2) | 300 | 1024 | 0 | 0 | 15991.55 | 18.69 | 12.53 | 68 | 99.06 | 24.168 |
|  HTTP/2 client and server downgrade service (h2 -> h2) | 1000 | 50 | 0 | 0 | 16092.42 | 62.04 | 28.99 | 163 | 97.22 | 25.053 |
|  HTTP/2 client and server downgrade service (h2 -> h2) | 1000 | 1024 | 0 | 0 | 15027.74 | 66.46 | 28.31 | 160 | 97.44 | 25.191 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h2) | 100 | 50 | 0 | 0 | 15945.72 | 6.1 | 7.38 | 42 | 99.55 | 24.089 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h2) | 100 | 1024 | 0 | 0 | 15305.07 | 6.27 | 7.67 | 44 | 99.57 | 23.931 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h2) | 300 | 50 | 0 | 0 | 16985.76 | 17.27 | 13.06 | 73 | 99.08 | 24.172 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h2) | 300 | 1024 | 0 | 0 | 15954.26 | 17.99 | 13.76 | 76 | 99.14 | 24.312 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h2) | 1000 | 50 | 0 | 0 | 16641.18 | 59.56 | 32.43 | 166 | 97.31 | 25.187 |
|  Passthrough HTTP/2(over TLS) service (h2 -> h2) | 1000 | 1024 | 0 | 0 | 15660.27 | 62.52 | 32.61 | 174 | 97.45 | 25.173 |