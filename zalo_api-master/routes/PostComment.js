const postCommentController = require("../controllers/PostComment");
const {asyncWrapper} = require("../utils/asyncWrapper");
const express = require("express");
const postCommentRoutes = express.Router();
const auth = require("../middlewares/auth");

postCommentRoutes.post(
    "/create/:postId",
    auth,
    asyncWrapper(postCommentController.create),
);

postCommentRoutes.get(
    "/list/:postId",
    auth,
    asyncWrapper(postCommentController.list),
);
module.exports = postCommentRoutes;