const mongoose = require("mongoose");
const {GENDER_SECRET} = require("../constants/constants");
const {GENDER_FEMALE} = require("../constants/constants");
const {GENDER_MALE} = require("../constants/constants");

const usersSchema = new mongoose.Schema({
    phonenumber: {
        type: String,
        required: true,
        unique: true
    },
    username: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true,
        max: 255,
        min: 6,
    },
    firstName: {
        type: String,
        required: false,
        max: 30,
    },
    lastName: {
        type: String,
        required: false,
        max: 30,
    },
    gender: {
        type: String,
        enum: [GENDER_MALE, GENDER_FEMALE, GENDER_SECRET],
        required: false,
        default: GENDER_SECRET,
    },
    birthday: {
        type: Date,
        required: false
    },
    description: {
        type: String,
        required: false,
    },
    address: {
        type: String,
        required: false,
    },
    city: {
        type: String,
        required: false,
    },
    country: {
        type: String,
        required: false,
    },
    link: {
        type: String,
        required: false,
    },
    avatar: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Documents',
    },
    cover_image: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Documents',
    },
    blocked_inbox: {
        type: Array,
        required: false
    },
    blocked_diary: {
        type: Array,
        required: false
    },
});

usersSchema.index({phonenumber: 'text'});
usersSchema.set('timestamps', true);
module.exports = mongoose.model('Users', usersSchema);
