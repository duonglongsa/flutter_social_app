const mongoose = require("mongoose");

const friendsSchema = new mongoose.Schema({
    sender: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Users"
    },
    receiver: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Users"
    },
    status: {
        type: String,
        required: true,
    }
});
friendsSchema.set('timestamps', true);
module.exports = mongoose.model('Friends', friendsSchema);
