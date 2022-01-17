require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const mainRouter = require("./routes/index");
const { PORT } = require("./constants/constants");
const { MONGO_URI } = require("./constants/constants");
const bodyParser = require("body-parser");
const http = require("http");

const {
	userJoin,
	getCurrentUser,
	userLeave,
	getRoomUsers,
} = require("./utils/usersGroupRealtime");

const app2 = express();
const chatServer = http.createServer(app2);
const { Server } = require("socket.io");
const io = new Server(chatServer);

// const io = require('socket.io')(3000)
// const MessageModel = require("../models/Messages");

// connect to mongodb
mongoose.set("useCreateIndex", true);
mongoose
	.connect(MONGO_URI, {
		useUnifiedTopology: true,
		useNewUrlParser: true,
	})
	.then((res) => {
		console.log("connected to mongodb");
	})
	.catch((err) => {
		console.log(err);
	});
const app = express();
// use middleware to parse body req to json
app.use(express.json());

// use middleware to enable cors
app.use(cors());
app.use(bodyParser.json({ limit: "50mb" }));
app.use(
	bodyParser.urlencoded({
		limit: "50mb",
		extended: true,
		parameterLimit: 50000,
	})
);
// route middleware
app.use("/", mainRouter);

app.get("/settings", function (req, res) {
	res.send("Settings Page");
});

app.listen(PORT, () => {
	console.log("server start - " + PORT);
});

// // Socket.io chat realtime
// io.on('connection', (socket) => {
//     MessageModel.find().then(result => {
//         socket.emit('output-messages', result)
//     })
//     console.log('a user connected');
//     socket.emit('message', 'Hello world');
//     socket.on('disconnect', () => {
//         console.log('user disconnected');
//     });
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
// });

// format message
const moment = require("moment");
const botName = "Nhom12";

function formatMessage(user_id,username, text) {
	return {
		user_id,
		username,
		text,
		time: moment().format(),
	};
}

// open socket
io.on("connection", function (socket) {
	socket.on("joinRoom", ({ username, user_id, room }) => {

        console.log('join room: ', user_id, room)
		const user = userJoin(socket.id, user_id, username, room);
		socket.join(user.room);

		console.log("user: " + user.user_id);
		socket.emit("message", formatMessage(user_id, botName, "Welcome!"));
		socket.broadcast
			.to(user.room)
			.emit(
				"message",
				formatMessage(user.user_id,botName, `${user.username} has joined the chat`)
			);

		// Send users and room info
		io.to(user.room).emit("roomUsers", {
			room: user.room,
			users: getRoomUsers(user.room),
		});
	});

	socket.on("chatMessage", (msg) => {
		const user = getCurrentUser(socket.id);
		io.to(user.room).emit("message", formatMessage(user.user_id,user.username, msg));
	});

	socket.on("disconnect", () => {
		const user = userLeave(socket.id);

		if (user) {
			io.to(user.room).emit(
				"message",
				formatMessage(user.user_id,botName, `${user.username} has left the chat`)
			);

			// Send users and room info
			io.to(user.room).emit("roomUsers", {
				room: user.room,
				users: getRoomUsers(user.room),
			});
		}
	});
});

chatServer.listen(3500, () => {
	console.log("server chat start - " + 3500);
});
