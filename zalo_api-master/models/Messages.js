const mongoose = require("mongoose");

const messagesSchema = new mongoose.Schema({
    chat: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Chats"
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Users"
    },
    content: {
        type: String,
        required: false
    }
});
messagesSchema.set('timestamps', true);
module.exports = mongoose.model('Messages', messagesSchema);
