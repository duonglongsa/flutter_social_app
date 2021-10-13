const postLikeController = require("../controllers/PostLike");
const {asyncWrapper} = require("../utils/asyncWrapper");
const express = require("express");
const postLikeRoutes = express.Router();
const auth = require("../middlewares/auth");

postLikeRoutes.post(
    "/action/:postId",
    auth,
    asyncWrapper(postLikeController.action),
);

module.exports = postLikeRoutes;