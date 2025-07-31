import ballerina/http;

service /users on new http:Listener(8080) {

    resource function post register(http:Caller caller, http:Request req) returns error? {
        // Convert request body to JSON
        json|error reqPayload = req.getJsonPayload();
        if reqPayload is json {
            // Forward request to Node.js backend
            http:Client backend = check new ("http://localhost:5000");
            http:Response response = check backend->post("/api/users/register", reqPayload);
            check caller->respond(response);
        } else {
            check caller->respond({ message: "Invalid JSON payload" });
        }
    }
}
