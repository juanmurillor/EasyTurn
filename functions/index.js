const functions = require('firebase-functions');
const admin  = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

var msgData;

/*exports.notificationTrigger = functions.firestore.document(
    'TurnosCaja/{turnoCajaId}'
).onDelete((snapshot,context)=>{
    msgData = snapshot.data();

    admin.firestore().collection('TurnosCaja_Tokens').get().then((snapshots)=>{
        var tokens = [];
        if (snapshots.empty) {
            console.log('No se encunetran Dispositivos');
        }
        else{
            for(var token of snapshots.docs){
                tokens.push(token.data().token);
            }

            var payload = {
                "notification":{
                    "title": "Numero Turno" + msgData.Turno,
                    "body": "Nombre" + msgData.Nombre,
                    "sound": "default"
                },
                "data":{
                    "sendername": msgData.Turno,
                    "message": msgData.Nombre
                }
            }
            return admin.messaging().sendToDevice(tokens, payload).then((response)=>{
                console.log('Pushed them all');
            }).catch((error)=>{
                console.log(error);
            })
        }
    })
})*/

exports.notificationTrigger = functions.firestore.document(
    'TurnosCaja/{turnoCajaId}'
).onCreate((snapshot,context)=>{
    msgData = snapshot.data();

    admin.firestore().collection('TurnosCaja_Tokens').get().then((snapshots)=>{
        var tokens = [];
        if (snapshots.empty) {
            console.log('No se encunetran Dispositivos');
        }
        else{
            for(var token of snapshots.docs){
                tokens.push(token.data().token);
            }

            var payload = {
                "notification":{
                    "title": "Numero Turno" + msgData.Turno,
                    "body": "Nombre" + msgData.Nombre,
                    "sound": "default"
                },
                "data":{
                    "sendername": msgData.Turno,
                    "message": msgData.Nombre
                }
            }
            return admin.messaging().sendToDevice(tokens, payload).then((response)=>{
                console.log('Pushed them all');
            }).catch((error)=>{
                console.log(error);
            })
        }
    })
})

