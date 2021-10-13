const jwt = require("jsonwebtoken");
const UserModel = require("../models/Users");
const httpStatus = require("../utils/httpStatus");

const auth = async (req, res, next) => {
  try {
    let authorization = req.headers.authorization.split(' ')[1], decoded;
    try {
        decoded = jwt.verify(authorization, process.env.JWT_SECRET);
    } catch (e) {
        return res.status(httpStatus.UNAUTHORIZED).json({
            success: false,
            message: 'unauthorized'
        });
    }
    const userId = decoded.id;
    let user;
    try {
        user = await UserModel.findById(userId);
        if (user == null) {
            return res.status(httpStatus.UNAUTHORIZED).json({
                message: "UNAUTHORIZED"
            });
        }
    } catch (error) {
        return res.status(httpStatus.INTERNAL_SERVER_ERROR).json({message: error.message});
    }

    req.userId = userId;
    next();
  } catch (err) {
      return res.status(httpStatus.INTERNAL_SERVER_ERROR).json({message: error.message});
  }
};

module.exports = auth;
