import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/chat_service.dart';
import 'package:social_app/services/friend_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {

  final  storage = const FlutterSecureStorage();
  String ?userId, token;
  String? roomId;
  IO.Socket? socket;
  User? user;
  // final messageList = <MessageModel>[].obs;
  // List<MessageModel> get messages => messageList.value;
  List<MessageModel> ?messageList;

  TextEditingController messageTextConntroller = TextEditingController();
 
  @override
  void onInit() async {
    super.onInit();
    userId = await storage.read(key: "userId");
    token = await storage.read(key: "token");
    messageList = await ChatService.getMessageList(token!, userId!, roomId!);
    user = await FriendService.getUserInfo(token!, userId!);

    socket = ChatService.getChatSocket();
    socket!.emit('joinRoom',{
      'username': user!.name,
      'room': roomId
    });
    socket!.on('message', (data){
      messageList!.add(MessageModel.fromSocket(data));
    });
    update();
  }
  
  void onSendTap() async {
    MessageModel message = MessageModel(User.id("618896ed249d4c08b0e85211"), roomId, messageTextConntroller.text);
    messageTextConntroller.clear();
    await ChatService.sendMessage(token!, message);
    messageList = await ChatService.getMessageList(token!, userId!, roomId!);
    socket!.emit('chatMessage', message.content);
    update();
  }

  void deleteMessage(String messageId) async {
    await ChatService.deleteMessage(token!, messageId); 
  }
  
}
