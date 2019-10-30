import ballerina/config;
import ballerina/io;
import ballerina/log;
import ldclakmal/gtasks;

gtasks:GTasksConfiguration gTasksConfig = {
    accessToken: config:getAsString("GOOGLE_ACCESS_TOKEN"),
    clientId: config:getAsString("GOOGLE_CLIENT_ID"),
    clientSecret: config:getAsString("GOOGLE_CLIENT_SECRET"),
    refreshToken: config:getAsString("GOOGLE_REFRESH_TOKEN")
};
gtasks:Client gTasksClient = new(gTasksConfig);

public function main() {
    var listTaksListResponse = gTasksClient->listTaskLists();
    if (listTaksListResponse is json) {
        io:println(listTaksListResponse);
    } else {
        log:printError("Failed to list task-list", listTaksListResponse);
    }

    var listTasksResponse = gTasksClient->listTasks("Ballerina Day");
    if (listTasksResponse is json) {
        io:println(listTasksResponse);
    } else {
        log:printError("Failed to list tasks", listTasksResponse);
    }

    json task = {
        "kind": "tasks#task",
        "id": "MTU1MjQzOTg1MzM3OTk0MTU2MzQ6MjMxMjc4NDQ3NDA5Mjk3NTo2MTE2OTU3ODQwMzAxNzE4",
        "etag": "\"84_7Cubo3y98GMV9bE3zQclHxhc/LTIwNDgyMDMwNTk\"",
        "title": "[⏰] Lunch @ 2:00PM",
        "updated": "2019-03-18T05:28:44.000Z",
        "selfLink": "https://www.googleapis.com/tasks/v1/lists/MTU1MjQzOTg1MzM3OTk0MTU2MzQ6MjMxMjc4NDQ3NDA5Mjk3NTow/tasks/MTU1MjQzOTg1MzM3OTk0MTU2MzQ6MjMxMjc4NDQ3NDA5Mjk3NTo2MTE2OTU3ODQwMzAxNzE4",
        "position": "00000000001610612734",
        "status": "needsAction"
    };

    var updateTaskResponse = gTasksClient->updateTask("Ballerina Day",
        "MDQ4NzI4NjE3OTU0OTE0OTgwNTg6Mzg5Nzc4MDI4OTUyNzI2NDo5ODQ5ODA3NzAwODk5ODA1", task);
    if (updateTaskResponse is json) {
        io:println(updateTaskResponse);
    } else {
        log:printError("Failed to update task", updateTaskResponse);
    }
}
