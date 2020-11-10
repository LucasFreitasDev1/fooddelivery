import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const getUserData = functions.https.onCall(async (data, context) => {
    if (!context.auth) {
        return {
            "data": "Nenhum usuário logado"
        };
    }

    console.log(context.auth.uid);

    const snapshot = await admin.firestore().collection("users").doc(context.auth.uid).get();

    console.log(snapshot.data());

    return {
        "data": snapshot.data()
    };
});

export const addMessage = functions.https.onCall(async (data, context) => {
    console.log(data);

    const snapshot = await admin.firestore().collection("messages").add(data);

    return { "success": snapshot.id };
});


const orderStatus = new Map([
    [1, "Em preparação"],
    [2, "Saiu para entrega"],
    [3, "Entregue"]
])

export const onOrderStatusChanged = functions.firestore.document("/orders/{orderId}").onUpdate(async (snapshot, context) => {
    const beforeStatus = snapshot.before.data().status;
    const afterStatus = snapshot.after.data().status;

    if (beforeStatus !== afterStatus) {
        const tokensUser = await getDeviceTokens(snapshot.after.data().clientId, false)

        await sendPushFCM(
            tokensUser,
            'Pedido: ' + context.params.orderId,
            'Status atualizado para: ' + orderStatus.get(afterStatus),
        )
    }
});

async function getDeviceTokens(uid: string, isAdmin: boolean) {
    if (isAdmin) {
        const querySnapshot = await admin.firestore().collection("admins").doc(uid).collection("tokens").get();

        const tokens = querySnapshot.docs.map(doc => doc.id);

        return tokens;
    } else {
        const querySnapshot = await admin.firestore().collection("users").doc(uid).collection("tokens").get();

        const tokens = querySnapshot.docs.map(doc => doc.id);

        return tokens;
    }
}

async function sendPushFCM(tokens: string[], title: string, message: string) {
    if (tokens.length > 0) {
        const payload = {
            notification: {
                title: title,
                body: message,
                click_action: 'FLUTTER_NOTIFICATION_CLICK'
            }
        };
        return admin.messaging().sendToDevice(tokens, payload);
    }
    return;
}