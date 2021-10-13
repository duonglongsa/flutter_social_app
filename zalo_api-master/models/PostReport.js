const mongoose = require("mongoose");

const postReportSchema = new mongoose.Schema({
    post: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Posts"
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Users"
    },
    subject: {
        type: String,
        required: false
    },
    details: {
        type: String,
        required: false
    },
    extraData: {
        type: JSON,
        required: false
    }
});
postReportSchema.set('timestamps', true);
module.exports = mongoose.model('PostReport', postReportSchema);
