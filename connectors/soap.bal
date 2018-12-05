import ballerina/io;
import ballerina/log;
import wso2/soap;

soap:Client soapClient = new("http://localhost:9000");

public function main() {
    log:printInfo("soapClient -> sendReceive()");

    xml body = xml `<m0:getQuote xmlns:m0="http://services.samples">
                        <m0:request>
                            <m0:symbol>WSO2</m0:symbol>
                        </m0:request>
                    </m0:getQuote>`;

    soap:SoapRequest soapRequest = {
        soapAction: "urn:getQuote",
        payload: body
    };

    var response = soapClient->sendReceive("/services/SimpleStockQuoteService", soapRequest);
    if (response is soap:SoapResponse) {
        io:println(response);
    } else {
        log:printError(<string>response.detail().message);
    }
}
