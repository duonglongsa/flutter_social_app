const postsController = require("../controllers/Posts");
const {asyncWrapper} = require("../utils/asyncWrapper");
const express = require("express");
const postsRoutes = express.Router();
const ValidationMiddleware = require("../middlewares/validate");
const auth = require("../middlewares/auth");

postsRoutes.post(
    "/create",
    auth,
    asyncWrapper(postsController.create)
);
postsRoutes.post(
    "/edit/:id",
    auth,
    asyncWrapper(postsController.edit)
);

postsRoutes.get(
    "/show/:id",
    auth,
    asyncWrapper(postsController.show),
);

postsRoutes.get(
    "/delete/:id",
    auth,
    asyncWrapper(postsController.delete),
);

postsRoutes.get(
    "/list",
    auth,
    asyncWrapper(postsController.list),
);


module.exports = postsRoutes;