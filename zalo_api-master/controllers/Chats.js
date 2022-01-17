const { PRIVATE_CHAT, GROUP_CHAT } = require("../constants/constants");
const ChatModel = require("../models/Chats");
const MessagesModel = require("../models/Messages");
const httpStatus = require("../utils/httpStatus");
const chatController = {};
chatController.send = async (req, res, next) => {
	try {
		let userId = req.userId;
		const { name, chatId, receivedId, member, type, content } = req.body;
		let chatIdSend = null;
		let chat;
		if (type === PRIVATE_CHAT) {
			if (chatId) {
				chat = await ChatModel.findById(chatId);
				if (chat !== null) {
					chatIdSend = chat._id;
				}
			} else {
				chat = new ChatModel({
					type: PRIVATE_CHAT,
					member: [receivedId, userId],
				});
				await chat.save();
				chatIdSend = chat._id;
			}
		} else if (type === GROUP_CHAT) {
			if (chatId) {
				chat = await ChatModel.findById(chatId);
				if (chat !== null) {
					chatIdSend = chat._id;
				}
			} else {
				chat = new ChatModel({
					type: GROUP_CHAT,
					member: member,
				});
				await chat.save();
				chatIdSend = chat._id;
			}
		}
		if (chatIdSend) {
			if (content) {
				let message = new MessagesModel({
					chat: chatIdSend,
					user: userId,
					content: content,
				});
				await message.save();
				let messageNew = await MessagesModel.findById(message._id)
					.populate("chat")
					.populate("user");
				return res.status(httpStatus.OK).json({
					data: messageNew,
				});
			} else {
				return res.status(httpStatus.OK).json({
					data: chat,
					message: "Create chat success",
					response: "CREATE_CHAT_SUCCESS",
				});
			}
		} else {
			return res.status(httpStatus.BAD_REQUEST).json({
				message: "Not chat",
			});
		}
	} catch (e) {
		return res.status(httpStatus.INTERNAL_SERVER_ERROR).json({
			message: e.message,
		});
	}
};

chatController.getMessages = async (req, res, next) => {
	try {
		let messages = await MessagesModel.find({
			chat: req.params.chatId,
		}).populate("user");
		return res.status(httpStatus.INTERNAL_SERVER_ERROR).json({
			data: messages,
		});
	} catch (e) {
		return res.status(httpStatus.INTERNAL_SERVER_ERROR).json({
			message: e.message,
		});
	}
};

// [POST] chats/getConversationList
chatController.getConversationList = async (req, res, next) => {
	const userId = req.userId;

	try {
		// find all chat that user take part in
		const conversation = await ChatModel.find({
			member: userId,
		}).lean();

		// lay mang cac id
		let chatId = conversation.map((c) => c._id);
		let messageArr = [];
		for (let id of chatId) {
			let mess = await MessagesModel.find({ chat: id })
				.sort({ createdAt: -1 })
				.limit(1);
			if (mess) {
				// console.log(mess);
				messageArr.push(mess);
			}
		}

		// console.log(messageArr);

		for (let i = 0; i < conversation.length; i++) {
			// cons
			conversation[i].lastMess = messageArr[i][0];
			// console.log('alo ',conversation[i].lastMess);
		}

		//conversation se la 1 mang cac cuoc hoi thoai,
		res.status(200).json({
			message: "fetching use conversation",
			data: conversation,
			// chatId: chatId
		});
	} catch (err) {
		res.status(httpStatus.INTERNAL_SERVER_ERROR).json(err);
	}
};

// [DELETE] /chats/deleteMessage/:id
chatController.deleteMessage = (req, res, next) => {
	const messId = req.params.id;
	// console.log("message deleted: ", messId);

	MessagesModel.findById(messId)
		.then((message) => {
			console.log("tin nhan muon xoa: ", message);
			message.content='Tin nhan da bi thu hoi'
			message.save();
			res.status(200).json({ message: "Message deleted" });
		})
		.catch((err) => {
			res.status(httpStatus.INTERNAL_SERVER_ERROR).json(err);
		});
};

// [DELETE] /chats/deleteConversation/:id
chatController.deleteConversation = (req, res, next) => {
	const conversationId = req.params.id;

	ChatModel.findByIdAndDelete(conversationId)
		.then((conversation) => {
			console.log("conversation: " + conversation);
			res.status(200).json({
				message: "Delete conversation successfully",
			});
		})
		.catch((err) => {
			res.status(httpStatus.INTERNAL_SERVER_ERROR).json(err);
		});
};

module.exports = chatController;
