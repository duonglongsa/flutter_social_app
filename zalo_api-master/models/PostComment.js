const mongoose = require("mongoose");

const postCommentSchema = new mongoose.Schema({
    post: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Posts"
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Users"
    },
    content: {
        type: String,
        required: false
    },
    commentAnswered: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "PostComment"
    }
});
postCommentSchema.set('timestamps', true);
module.exports = mongoose.model('PostComment', postCommentSchema);
