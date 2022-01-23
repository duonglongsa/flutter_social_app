const users = [];

// Join user to chat
function userJoin(id ,user_id, username, room) {
  const user = { id ,user_id, username, room };
  console.log('user: ', user);
  users.push(user);

  return user;
}

// Get current user
function getCurrentUser(id) {
  let myUser = users.find(user => user.id === id);
  console.log('sao v: ',myUser);
  return myUser;
}

function getOtherUser(id) {
  console.log("users", users);
  let myUser = users.find(user => user.id !== id);
  console.log('sao v: ',myUser);
  return myUser;
}

// User leaves chat
function userLeave(id) {
  const index = users.findIndex(user => user.id === id);

  if (index !== -1) {
    return users.splice(index, 1)[0];
  }
}

// Get room users
function getRoomUsers(room) {
  return users.filter(user => user.room === room);
}

module.exports = {
  userJoin,
  getCurrentUser,
  userLeave,
  getRoomUsers,
  getOtherUser
};