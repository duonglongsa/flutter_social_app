const PostReportModel = require("../models/PostReport");
const PostModel = require("../models/Posts");
const httpStatus = require("../utils/httpStatus");
const postReportController = {};
postReportController.create = async (req, res, next) => {
    try {
        let userId = req.userId;
        let post = await (await PostModel.findById(req.params.postId));
        if (post == null) {
            return res.status(httpStatus.NOT_FOUND).json({message: "Can not find post"});
        }
        const {
            subject,
            details,
        } = req.body;

        const postReport = new PostReportModel({
            user: userId,
            post: post._id,
            subject: subject,
            details: details
        });
        let postReportSaved = await postReport.save();
        postReportSaved = await PostReportModel.findById(postReportSaved._id).populate('post', ['described']).populate('user', ['username', 'phonenumber']);
        return res.status(httpStatus.OK).json({
            data: postReportSaved
        });
    } catch (e) {
        return res.status(httpStatus.INTERNAL_SERVER_ERROR).json({
            message: e.message
        });
    }
}

module.exports = postReportController;