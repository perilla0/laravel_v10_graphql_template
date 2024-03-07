db = db.getSiblingDB('mail');
db = db.getSiblingDB("main");
db.createUser({
    user: "root",
    pwd: "password",
    roles: [
        {role: "root", db: "mail"},
        {role: "root", db: "main"},
    ]
});
// db.createUser({
//     user: "root",
//     pwd: "password",
//     roles: [
//         { role : "dbOwner", db : "main" },
//         { role : "dbAdmin", db : "main" },
//         { role : "readWrite", db : "main" },
//     ]
// });