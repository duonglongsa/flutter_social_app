import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/chat_service.dart';
import 'package:social_app/services/friend_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  final storage = const FlutterSecureStorage();
  String? userId, token;
  String? roomId;
  IO.Socket? socket;
  User? user;
  bool isTyping = false;
  // final messageList = <MessageModel>[].obs;
  // List<MessageModel> get messages => messageList.value;
  List<MessageModel>? messageList;

  TextEditingController messageTextConntroller = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    userId = await storage.read(key: "userId");
    token = await storage.read(key: "token");
    messageList = await ChatService.getMessageList(token!, userId!, roomId!);
    user = await FriendService.getUserInfo(token!, userId!);
    socket = ChatService.getChatSocket();
    socket!.emit('joinRoom', {
      'username': user!.name,
      'user_id': userId,
      'room': roomId,
    });
    socket!.on('message', (data) {
      MessageModel newMessage = MessageModel.fromSocket(data);
      newMessage.sender!.id == userId ? newMessage.isSender = true : false;
      messageList!.add(newMessage);
      update();
    });
    socket!.on('typing', (data) {
      if (data["id"] != userId) {
        isTyping = true;
        update();
      }
    });
    socket!.on('stopTyping', (data) {
      if (data["id"] != userId) {
        isTyping = false;
        update();
      }
    });
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    update();
  }

  Future onSendTap() async {
    MessageModel message = MessageModel(User.id("618896ed249d4c08b0e85211"),
        roomId, messageTextConntroller.text);
    messageTextConntroller.clear();
    await ChatService.sendMessage(token!, message);
    socket!.emit('chatMessage', message.content);
    update();
  }

  void deleteMessage(String messageId) async {
    await ChatService.deleteMessage(token!, messageId);
    update();
  }

  void onTypingMessage() {
    socket!.emit('typing', 'typing');
  }

  void onStopTypingMessage() {
    socket!.emit('stopTyping', 'stopTyping');
  }
}
