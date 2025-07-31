import ballerina/http;

service /users on new http:Listener(8080) {
    resource function post register(http:Caller caller, http:Request req) returns error? {
        // Forward request to Node.js
        http:Client backend = check new ("http://localhost:5000");
        var response = backend->post("/api/users/register", req);
        check caller->respond(response);
    }
}
