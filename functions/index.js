const functions = require("firebase-functions");

const admin = require("firebase-admin");
const { firestore } = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

var msgData;

exports.orderTrigger = functions.firestore.document("ordersPlaced/{orderID}")
.onCreate((snapshot, context) => {
    msgData = snapshot.data();

    admin.firestore().collection("adminTokens").get().then((snapshots)=>{
        var tokens = [];
        if(snapshots.empty)
        {
            console.log("no tokens");
        }
        else
        {
            for(var token of snapshots.docs)
            {
                tokens.push(token.data);
            }

            var payload = {
                "notifications": {
                    "title": "New order placed",
                    "body": msgData.username+" placed a new order of "+msgData.name,
                    "sound": "default"
                },

                "data":{
                    "senderName": msgData.username,
                    "message": msgData.name+" "+msgData.quan
                }
            }

            return admin.messaging().sendToDevice(tokens, payload).then((response) => {
                console.log("notified");
            }).catch((err) => {
                console.log(err);
            });
        }
    })
})

exports.orderTrigger = functions.firestore.document("vegetables/{vegID}")
.onCreate((snapshot, context) => {
    msgData = snapshot.data();

    admin.firestore().collection("cusTokens").get().then((snapshots)=>{
        var tokens = [];
        if(snapshots.empty)
        {
            console.log("no tokens");
        }
        else
        {
            for(var token of snapshots.docs)
            {
                tokens.push(token.data);
            }

            var payload = {
                "notifications": {
                    "title": "New offer available",
                    "body": "Get new deals on "+msgData.vegName,
                    "sound": "default"
                },

                "data":{
                    "senderName": msgData.username,
                    "message": msgData.vegName+" "+msgData.price
                }
            }

            return admin.messaging().sendToDevice(tokens, payload).then((response) => {
                console.log("notified");
            }).catch((err) => {
                console.log(err);
            });
        }
    })
})

