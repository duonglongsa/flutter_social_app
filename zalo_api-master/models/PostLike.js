const mongoose = require("mongoose");

const postLikeSchema = new mongoose.Schema({
    post: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Posts"
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Users"
    },
    extraData: {
        type: JSON,
        required: false
    }
});
postLikeSchema.set('timestamps', true);
module.exports = mongoose.model('PostLike', postLikeSchema);
