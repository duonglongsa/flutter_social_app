//Validation
const Joi = require('joi');

const registerValidation = (data) => {
    const schema = Joi.object({
        name: Joi.string().required(),
        password: Joi.string().pattern(new RegExp('^[a-zA-Z0-9]{6,128}$')),
        address: Joi.string().min(1).max(1000).required(),
        email: Joi.string().min(6).email(),
        role: Joi.string().valid(
            'admin',
            'customer',
            'inventoryManager',
            'cashier'
        ),
        gender: Joi.string().valid('male', 'female', 'secret'),
        phone: Joi.string().min(10).max(11).required(),
        birthday: Joi.string().pattern(new RegExp('^[0-9-]*$')),
        photo: Joi.string()
    });

    // function isVietnamesePhoneNumber() {
    // 	return /(03|07|08|09|01[2|6|8|9])+([0-9]{8})\b/.test(data.phone);
    // }

    return schema.validate(data);
};
function removeAscent(str) {
    if (str === null || str === undefined) return str;
    str = str.toLowerCase();
    str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, 'a');
    str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, 'e');
    str = str.replace(/ì|í|ị|ỉ|ĩ/g, 'i');
    str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, 'o');
    str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, 'u');
    str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, 'y');
    str = str.replace(/đ/g, 'd');
    return str;
}
//Kiểm tra tên có hợp lệ hay không
function isnameValid(string) {
    var re = /^[a-zA-Z' ]+$/; // regex here
    return re.test(removeAscent(string));
}

const loginValidation = (data) => {
    const schema = Joi.object({
        password: Joi.string().pattern(new RegExp('^[a-zA-Z0-9]{6,128}$')),
        email: Joi.string().min(6).email(),
    });
    return schema.validate(data);
};

module.exports.registerValidation = registerValidation;
module.exports.loginValidation = loginValidation;
