const jwt = require("jsonwebtoken");
const httpStatus = require("../utils/httpStatus");
const {ROLE_ADMIN} = require("../constants/constants");
const {JWT_SECRET} = require("../constants/constants");
exports.validJWTNeeded = (req, res, next) => {
	if (req.headers['authorization']) {
		try {
			let authorization = req.headers['authorization'].split(' ');
			if (authorization[0] !== 'Bearer') {
				return res.status(httpStatus.UNAUTHORIZED).json({
					message: "UNAUTHORIZED"
				});
			} else {
				req.jwt = jwt.verify(authorization[1], JWT_SECRET);
				return next();
			}
		} catch (err) {
			return res.status(httpStatus.FORBIDDEN).json({
				message: "FORBIDDEN"
			});
		}
	} else {
		return res.status(httpStatus.UNAUTHORIZED).json({
			message: "UNAUTHORIZED"
		});
	}
};

exports.validJWTAdmin = (req, res, next) => {
	if (req.headers['authorization']) {
		try {
			let authorization = req.headers['authorization'].split(' ');
			if (authorization[0] !== 'Bearer') {
				return res.status(httpStatus.UNAUTHORIZED).json({
					message: "UNAUTHORIZED"
				});
			} else {
				req.jwt = jwt.verify(authorization[1], JWT_SECRET, (err, payload) => {
					if (err) {
						return res.status(httpStatus.UNAUTHORIZED).json({
							message: "UNAUTHORIZED"
						});
					} else {
						if (payload.role === ROLE_ADMIN) {
							return next();
						} else {
							return res.status(httpStatus.FORBIDDEN).json({
								message: "FORBIDDEN"
							});
						}
					}
				});
			}
		} catch (err) {
			return res.status(httpStatus.FORBIDDEN).json({
				message: "FORBIDDEN"
			});
		}
	} else {
		return res.status(httpStatus.UNAUTHORIZED).json({
			message: "UNAUTHORIZED"
		});
	}
};

