# Ballerina Performance Test Results

During each release, we execute various automated performance test scenarios and publish the results.

| Test Scenarios | Description |
| --- | --- |
| Passthrough HTTP service (h1c -> h1c) | An HTTP Service, which forwards all requests to an HTTP back-end service. |
| Passthrough HTTPS service (h1 -> h1) | An HTTPS Service, which forwards all requests to an HTTPS back-end service. |
| JSON to XML transformation HTTP service | An HTTP Service, which transforms JSON requests to XML and then forwards all requests to an HTTP back-end service. |
| JSON to XML transformation HTTPS service | An HTTPS Service, which transforms JSON requests to XML and then forwards all requests to an HTTPS back-end service. |
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
,  Passthrough HTTP service (h1c -> h1c) , 100 , 50 , 0 , 0 , 20060.18 , 4.94 , 3.73 , 15 , 99.57 , 7279 ,
,  Passthrough HTTP service (h1c -> h1c) , 100 , 1024 , 0 , 0 , 18473.21 , 5.37 , 4.02 , 17 , 99.56 , 7725 ,
,  Passthrough HTTP service (h1c -> h1c) , 300 , 50 , 0 , 0 , 20076.42 , 14.89 , 7.92 , 37 , 99.14 , 8268 ,
,  Passthrough HTTP service (h1c -> h1c) , 300 , 1024 , 0 , 0 , 18222.65 , 16.39 , 35.01 , 41 , 99.04 , 8307 ,
,  Passthrough HTTP service (h1c -> h1c) , 1000 , 50 , 0 , 0 , 16779.99 , 59.52 , 21.98 , 121 , 97.7 , 8822 ,
,  Passthrough HTTP service (h1c -> h1c) , 1000 , 1024 , 0 , 0 , 17030.94 , 58.55 , 124.19 , 122 , 97.73 , 8782 ,
,  JSON to XML transformation HTTP service , 100 , 50 , 0 , 0 , 11869.63 , 8.38 , 9.08 , 39 , 99.26 , 15.104 ,
,  JSON to XML transformation HTTP service , 100 , 1024 , 0 , 0 , 9442.32 , 10.55 , 12.66 , 56 , 99.29 , 15.063 ,
,  JSON to XML transformation HTTP service , 300 , 50 , 0 , 0 , 14163.59 , 21.13 , 13.29 , 61 , 98.31 , 15.077 ,
,  JSON to XML transformation HTTP service , 300 , 1024 , 0 , 0 , 9566.73 , 31.29 , 22.02 , 98 , 98.46 , 15.051 ,
,  JSON to XML transformation HTTP service , 1000 , 50 , 0 , 0 , 13333.9 , 74.92 , 29.91 , 159 , 95.24 , 15.761 ,
,  JSON to XML transformation HTTP service , 1000 , 1024 , 0 , 0 , 9493.41 , 105.25 , 45.76 , 233 , 95.21 , 15.678 ,
,  Passthrough HTTPS service (h1 -> h1) , 100 , 50 , 0 , 0 , 16792.33 , 5.91 , 3.69 , 16 , 99.55 , 14.538 ,
,  Passthrough HTTPS service (h1 -> h1) , 100 , 1024 , 0 , 0 , 11959.22 , 8.31 , 4.24 , 20 , 99.61 , 14.539 ,
,  Passthrough HTTPS service (h1 -> h1) , 300 , 50 , 0 , 0 , 16520.95 , 18.1 , 8.85 , 43 , 99.11 , 14.774 ,
,  Passthrough HTTPS service (h1 -> h1) , 300 , 1024 , 0 , 0 , 12161.06 , 24.6 , 10.31 , 54 , 99.21 , 14.801 ,
,  Passthrough HTTPS service (h1 -> h1) , 1000 , 50 , 0 , 0 , 14459.64 , 69.08 , 24.37 , 138 , 97.69 , 16.071 ,
,  Passthrough HTTPS service (h1 -> h1) , 1000 , 1024 , 0 , 0 , 11428.27 , 87.42 , 28.03 , 165 , 97.8 , 15.845 ,
,  JSON to XML transformation HTTPS service , 100 , 50 , 0 , 0 , 12237.91 , 8.13 , 7.48 , 32 , 99.2 , 14.305 ,
,  JSON to XML transformation HTTPS service , 100 , 1024 , 0 , 0 , 7315.63 , 13.62 , 11.76 , 54 , 99.35 , 8900 ,
,  JSON to XML transformation HTTPS service , 300 , 50 , 0 , 0 , 12427.32 , 24.08 , 13.43 , 64 , 98.4 , 14.575 ,
,  JSON to XML transformation HTTPS service , 300 , 1024 , 0 , 0 , 7472.12 , 40.08 , 23.22 , 111 , 98.48 , 14.854 ,
,  JSON to XML transformation HTTPS service , 1000 , 50 , 0 , 0 , 11449.94 , 87.25 , 31.79 , 176 , 95.51 , 15.949 ,
,  JSON to XML transformation HTTPS service , 1000 , 1024 , 0 , 0 , 7110.74 , 140.53 , 53.1 , 291 , 95.43 , 15.881 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h1c) , 100 , 50 , 0 , 0 , 15306.49 , 6.33 , 3.88 , 17 , 99.59 , 9078 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h1c) , 100 , 1024 , 0 , 0 , 14677.25 , 6.5 , 3.84 , 17 , 99.6 , 9135 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h1c) , 300 , 50 , 0 , 0 , 14844.07 , 19.73 , 9.56 , 47 , 99.19 , 9552 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h1c) , 300 , 1024 , 0 , 0 , 14405.27 , 19.97 , 9.53 , 48 , 99.19 , 15.583 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h1c) , 1000 , 50 , 0 , 0 , 13772.18 , 72.1 , 25.69 , 147 , 97.65 , 16.369 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h1c) , 1000 , 1024 , 0 , 0 , 13583.39 , 72.04 , 26.54 , 149 , 97.7 , 10.093 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h1) , 100 , 50 , 0 , 0 , 13825.02 , 7.04 , 3.96 , 18 , 99.57 , 15.113 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h1) , 100 , 1024 , 0 , 0 , 11656.77 , 8.31 , 4.15 , 21 , 99.6 , 15.125 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h1) , 300 , 50 , 0 , 0 , 13633.05 , 21.56 , 10.03 , 50 , 99.11 , 15.369 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h1) , 300 , 1024 , 0 , 0 , 11700.39 , 24.96 , 10.63 , 56 , 99.14 , 15.587 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h1) , 1000 , 50 , 0 , 0 , 12335.99 , 80.42 , 27.1 , 158 , 97.46 , 16.299 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h1) , 1000 , 1024 , 0 , 0 , 10723.62 , 92.26 , 29.41 , 174 , 97.6 , 16.327 ,
,  HTTP/2 client and server downgrade service (h2 -> h2) , 100 , 50 , 0 , 0 , 17488.71 , 5.67 , 3.72 , 16 , 99.59 , 15.215 ,
,  HTTP/2 client and server downgrade service (h2 -> h2) , 100 , 1024 , 0 , 0.64 , 492.13 , 193.43 , 2396.54 , 65 , 99.91 , 9205 ,
,  HTTP/2 client and server downgrade service (h2 -> h2) , 300 , 50 , 0 , 0 , 17323.65 , 17.26 , 8.71 , 42 , 99.2 , 15.439 ,
,  HTTP/2 client and server downgrade service (h2 -> h2) , 300 , 1024 , 0 , 0 , 15130.44 , 19.76 , 9.44 , 47 , 99.28 , 9321 ,
,  HTTP/2 client and server downgrade service (h2 -> h2) , 1000 , 50 , 0 , 0 , 14809.78 , 67.45 , 23.5 , 133 , 97.93 , 16.355 ,
,  HTTP/2 client and server downgrade service (h2 -> h2) , 1000 , 1024 , 0 , 0 , 14170.98 , 70.49 , 24.51 , 140 , 98.05 , 16.471 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h2) , 100 , 50 , 0 , 0 , 15030.16 , 6.45 , 4.04 , 18 , 99.64 , 15.134 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h2) , 100 , 1024 , 0 , 0 , 14504.53 , 6.59 , 3.96 , 18 , 99.65 , 15.123 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h2) , 300 , 50 , 0 , 0 , 15385.08 , 19.06 , 9.62 , 47 , 99.32 , 15.589 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h2) , 300 , 1024 , 0 , 0 , 14905.68 , 19.29 , 9.59 , 48 , 99.34 , 15.59 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h2) , 1000 , 50 , 0 , 0 , 14773.52 , 67.26 , 24.67 , 137 , 98.12 , 16.357 ,
,  Passthrough HTTP/2(over TLS) service (h2 -> h2) , 1000 , 1024 , 0 , 0 , 14008.06 , 70.06 , 28.62 , 145 , 98.12 , 16.324 ,