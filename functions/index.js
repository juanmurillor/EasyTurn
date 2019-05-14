const functions = require('firebase-functions');
const admin  = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

var msgData;
// TURNOS CAJA
exports.notificationTriggerDelete_Turnos_Caja = functions.firestore.document(
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
                    "title": "Caja - Siguiente Turno",
                    "body": "Acabo de Terminar el Turno #: " + msgData.Turno,
                    "sound": "default"
                },
                "data":{
                    "sendername": toString(msgData.Turno),
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

exports.notificationTriggerCreate_Turnos_Caja = functions.firestore.document(
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
                    "title": "Caja - Nuevo Turno",
                    "body": "Se ha Creado el turno #: " + msgData.Turno,
                    "sound": "default"
                },
                "data":{
                    "sendername": toString(msgData.Turno),
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
// TURNOS ACADEMICO
exports.notificationTriggerDelete_Turnos_Academico = functions.firestore.document(
    'TurnosAcademico/{turnoAcademicoId}'
).onDelete((snapshot,context)=>{
    msgData = snapshot.data();

    admin.firestore().collection('TurnosAcademico_Tokens').get().then((snapshots)=>{
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
                    "title": "Academico - Siguiente Turno",
                    "body": "Acabo de Terminar el Turno #: " + msgData.Turno,
                    "sound": "default"
                },
                "data":{
                    "sendername": toString(msgData.Turno),
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

exports.notificationTriggerCreate_Turnos_Academico = functions.firestore.document(
    'TurnosAcademico/{turnoAcademicoId}'
).onCreate((snapshot,context)=>{
    msgData = snapshot.data();

    admin.firestore().collection('TurnosAcademico_Tokens').get().then((snapshots)=>{
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
                    "title": "Academico - Nuevo Turno",
                    "body": "Se ha Creado el turno #: " + msgData.Turno,
                    "sound": "default"
                },
                "data":{
                    "sendername": toString(msgData.Turno),
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
// TURNOS FINANCIERO
exports.notificationTriggerDelete_Turnos_Financiero = functions.firestore.document(
    'TurnosFinanciero/{turnoFinancieroId}'
).onDelete((snapshot,context)=>{
    msgData = snapshot.data();

    admin.firestore().collection('TurnosFinanciero_Tokens').get().then((snapshots)=>{
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
                    "title": "Financiero - Siguiente Turno",
                    "body": "Acabo de Terminar el Turno #: " + msgData.Turno,
                    "sound": "default"
                },
                "data":{
                    "sendername": toString(msgData.Turno),
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

exports.notificationTriggerCreate_Turnos_Financiero = functions.firestore.document(
    'TurnosFinanciero/{turnoFinancieroId}'
).onCreate((snapshot,context)=>{
    msgData = snapshot.data();

    admin.firestore().collection('TurnosFinanciero_Tokens').get().then((snapshots)=>{
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
                    "title": "Financiero - Nuevo Turno",
                    "body": "Se ha Creado el turno #: " + msgData.Turno,
                    "sound": "default"
                },
                "data":{
                    "sendername": toString(msgData.Turno),
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

