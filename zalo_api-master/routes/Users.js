const usersController = require("../controllers/Users");
const {asyncWrapper} = require("../utils/asyncWrapper");
const express = require("express");
const usersRoutes = express.Router();
const ValidationMiddleware = require("../middlewares/validate");
const auth = require("../middlewares/auth");

usersRoutes.post(
    "/register",
    asyncWrapper(usersController.register)
);
usersRoutes.post(
    "/login",
    asyncWrapper(usersController.login)
);
usersRoutes.post(
    "/edit",
    auth,
    asyncWrapper(usersController.edit),
);
usersRoutes.post(
    "/change-password",
    auth,
    asyncWrapper(usersController.changePassword),
);
usersRoutes.get(
    "/show",
    auth,
    asyncWrapper(usersController.show),
);

usersRoutes.get(
    "/show/:id",
    auth,
    asyncWrapper(usersController.show),
);


usersRoutes.post("/set-block-user", auth, usersController.setBlock);
usersRoutes.post("/set-block-diary", auth, usersController.setBlockDiary);
usersRoutes.post("/search", auth, usersController.searchUser);

module.exports = usersRoutes;