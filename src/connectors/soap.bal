import ballerina/io;
import ballerina/log;
import wso2/soap;

soap:Soap11Client soapClient = new("http://localhost:9000");

public function main() {
    log:printInfo("soapClient -> sendReceive()");

    xml body = xml `<m0:getQuote xmlns:m0="http://services.samples">
                        <m0:request>
                            <m0:symbol>WSO2</m0:symbol>
                        </m0:request>
                    </m0:getQuote>`;

    var response = soapClient->sendReceive("/services/SimpleStockQuoteService", "urn:getQuote", body);
    if (response is soap:SoapResponse) {
        io:println(response);
    } else {
        log:printError(<string>response.detail().message);
    }
}
