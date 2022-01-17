require('dotenv').config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const mainRouter = require("./routes/index");
const {PORT} = require("./constants/constants");
const {MONGO_URI} = require("./constants/constants");
const bodyParser = require('body-parser');
const io = require('socket.io')(3000)
// const MessageModel = require("../models/Messages");

// connect to mongodb
mongoose.set('useCreateIndex', true)
mongoose.connect(MONGO_URI, {
    useUnifiedTopology: true,
    useNewUrlParser: true,
})
    .then(res => {
    console.log("connected to mongodb");
})
    .catch(err => {
        console.log(err);
    })
const app = express();
// use middleware to parse body req to json
app.use(express.json());

// use middleware to enable cors
app.use(cors());
app.use(bodyParser.json({limit: "50mb"}));
app.use(bodyParser.urlencoded({limit: "50mb", extended: true, parameterLimit:50000}));
// route middleware
app.use("/", mainRouter);

app.get('/settings', function (req, res) {
    res.send('Settings Page');
});


app.listen(PORT, () => {
    console.log("server start - " + PORT);
})

// Socket.io chat realtime
io.on('connection', (socket) => {
    MessageModel.find().then(result => {
        socket.emit('output-messages', result)
    })
    console.log('a user connected');
    socket.emit('message', 'Hello world');
    socket.on('disconnect', () => {
        console.log('user disconnected');
    });
    // socket.on('chatmessage', msg => {
    //     const message = new MessageModel({ msg });
    //     message.save().then(() => {
    //         io.emit('message', msg)
    //     })
    // })
    // socket.on('chatmessage', async (msg) => {
    //     // console.log(msg.token)
    //     // if (msg.token && msg.receiverId) {
    //         try {
    //             // decoded = jwt.verify(msg.token, process.env.JWT_SECRET);
    //             // msg.senderId = decoded.id;
    //             // delete msg.token;
    //             // msg.time = new Date();
    //             data = await chatController.saveMessage(msg);
    //             if (data !== null) {
    //                 msg.chatId = data.chatId;
    //                 msg._id = data.msgId;
    //                 //mh can xem

    //                 if (socketIds[msg.senderId]) {
    //                     for (let i = 0; i < socketIds[msg.senderId].length; i++) {
    //                         io.to(socketIds[msg.senderId][i]).emit('message', msg);
    //                     }
    //                 }
    //                 if (socketIds[msg.receiverId]) {
    //                     for (let i = 0; i < socketIds[msg.receiverId].length; i++) {
    //                         io.to(socketIds[msg.receiverId][i]).emit('message', msg);
    //                     }
    //                 }
    //             }
    //         } catch (e) {
    //             console.log(e);
    //         }
    //     // }
    // })
});
