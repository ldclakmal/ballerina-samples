import ballerina/config;
import ballerina/http;
import ballerina/log;
import ballerina/ldap;

ldap:LdapConnectionConfig ldapConfig = {
    domainName: "avix.lk",
    connectionURL: "ldap://localhost:389",
    connectionName: "cn=admin,dc=avix,dc=lk",
    connectionPassword: "avix123",
    userSearchBase: "ou=Users,dc=avix,dc=lk",
    userEntryObjectClass: "inetOrgPerson",
    userNameAttribute: "uid",
    userNameSearchFilter: "(&(objectClass=inetOrgPerson)(uid=?))",
    userNameListFilter: "(objectClass=inetOrgPerson)",
    groupSearchBase: ["ou=Groups,dc=avix,dc=lk"],
    groupEntryObjectClass: "groupOfNames",
    groupNameAttribute: "cn",
    groupNameSearchFilter: "(&(objectClass=groupOfNames)(cn=?))",
    groupNameListFilter: "(objectClass=groupOfNames)",
    membershipAttribute: "member",
    userRolesCacheEnabled: true,
    connectionPoolingEnabled: false,
    connectionTimeoutInMillis: 5000,
    readTimeoutInMillis: 60000,
    retryAttempts: 3
};
ldap:InboundLdapAuthProvider ldapAuthProvider = new(ldapConfig, "openldap-server");
http:BasicAuthHandler ldapAuthHandler = new(ldapAuthProvider);

listener http:Listener ep = new (9090, {
    auth: {
        authHandlers: [ldapAuthHandler]
    },
    secureSocket: {
        keyStore: {
            path: config:getAsString("b7a.home") + "/bre/security/ballerinaKeystore.p12",
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
