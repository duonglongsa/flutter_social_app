const chatController = require("../controllers/Chats");
const { asyncWrapper } = require("../utils/asyncWrapper");
const express = require("express");
const chatsRoutes = express.Router();
const auth = require("../middlewares/auth");

chatsRoutes.post("/send", auth, asyncWrapper(chatController.send));

chatsRoutes.get(
	"/getMessages/:chatId",
	auth,
	asyncWrapper(chatController.getMessages)
);

chatsRoutes.post(
	"/getConversationList",
	auth,
	asyncWrapper(chatController.getConversationList)
);

chatsRoutes.delete(
	"/deleteConversation/:id",
	auth,
	asyncWrapper(chatController.deleteConversation)
);

chatsRoutes.delete(
	"/deleteMessage/:id",
	auth,
	asyncWrapper(chatController.deleteMessage)
);

module.exports = chatsRoutes;
