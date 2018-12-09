import ballerina/config;
import ballerina/http;
import ballerina/io;
import ballerina/log;
import chanakal/gtasks;

gtasks:GTasksConfiguration gTasksConfig = {
    clientConfig: {
        auth: {
            scheme: http:OAUTH2,
            accessToken: config:getAsString("GOOGLE_ACCESS_TOKEN"),
            clientId: config:getAsString("GOOGLE_CLIENT_ID"),
            clientSecret: config:getAsString("GOOGLE_CLIENT_SECRET"),
            refreshToken: config:getAsString("GOOGLE_REFRESH_TOKEN")
        }
    }
};

gtasks:Client gTasksClient = new(gTasksConfig);

public function main() {
    var listTaksListResponse = gTasksClient->listTaskLists();
    if (listTaksListResponse is json) {
        io:println(listTaksListResponse);
    } else {
        log:printError(<string>listTaksListResponse.detail().message);
    }

    var listTasksResponse = gTasksClient->listTasks("BallerinaDay");
    if (listTasksResponse is json) {
        io:println(listTasksResponse);
    } else {
        log:printError(<string>listTasksResponse.detail().message);
    }

    json task = {
        "kind": "tasks#task",
        "id": "MDQ4NzI4NjE3OTU0OTE0OTgwNTg6Mzg5Nzc4MDI4OTUyNzI2NDo5ODQ5ODA3NzAwODk5ODA1",
        "etag": "\"FhCqMAsBrrKDkDLKevwtJykQ9I8/LTY2NDI3MjAyNQ\"",
        "title": "[⏰] Lunch @ 1:00PM",
        "updated": "2018-08-10T06:11:36.000Z",
        "selfLink":
        "https://www.googleapis.com/tasks/v1/lists/MDQ4NzI4NjE3OTU0OTE0OTgwNTg6Mzg5Nzc4MDI4OTUyNzI2NDow/tasks/MDQ4NzI4NjE3OTU0OTE0OTgwNTg6Mzg5Nzc4MDI4OTUyNzI2NDo5ODQ5ODA3NzAwODk5ODA1",
        "position": "00000000000975315488",
        "status": "needsAction"
    };

    var updateTaskResponse = gTasksClient->updateTask("BallerinaDay",
        "MDQ4NzI4NjE3OTU0OTE0OTgwNTg6Mzg5Nzc4MDI4OTUyNzI2NDo5ODQ5ODA3NzAwODk5ODA1", task);
    if (updateTaskResponse is json) {
        io:println(updateTaskResponse);
    } else {
        log:printError(<string>updateTaskResponse.detail().message);
    }
}
