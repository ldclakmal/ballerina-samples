// https://github.com/rroemhild/docker-test-openldap

import ballerina/http;
import ballerina/config;
import ballerina/log;
import ballerina/ldap;

ldap:LdapConnectionConfig ldapConfig = {
    domainName: "planetexpress.com",
    //connectionURL: "ldaps://localhost:636",
    connectionURL: "ldap://localhost:389",
    connectionName: "cn=admin,dc=planetexpress,dc=com",
    connectionPassword: "GoodNewsEveryone",
    userSearchBase: "ou=people,dc=planetexpress,dc=com",
    userEntryObjectClass: "inetOrgPerson",
    userNameAttribute: "uid",
    userNameSearchFilter: "(&(objectClass=inetOrgPerson)(uid=?))",
    userNameListFilter: "(objectClass=inetOrgPerson)",
    groupSearchBase: ["ou=people,dc=planetexpress,dc=com"],
    groupEntryObjectClass: "Group",
    groupNameAttribute: "cn",
    groupNameSearchFilter: "(&(objectClass=Group)(cn=?))",
    groupNameListFilter: "(objectClass=Group)",
    membershipAttribute: "member",
    userRolesCacheEnabled: true,
    connectionPoolingEnabled: false,
    connectionTimeoutInMillis: 5000,
    readTimeoutInMillis: 60000,
    retryAttempts: 3
    secureSocket: {
        trustedCertFile: "/path/to/cert.pem"
    }
};
ldap:InboundLdapAuthProvider ldapAuthProvider = new(ldapConfig, "ldap01");
http:BasicAuthHandler ldapAuthHandler = new(ldapAuthProvider);

listener http:Listener ep = new (9090, {
    auth: {
        authHandlers: [ldapAuthHandler]
    },
    secureSocket: {
        keyStore: {
            path: config:getAsString("b7a.home") +
                  "/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

service hello on ep {
    resource function sayHello(http:Caller caller, http:Request req) {
        error? result = caller->respond("Hello, World!!!");
        if (result is error) {
            log:printError("Error in responding to caller", result);
        }
    }
}
