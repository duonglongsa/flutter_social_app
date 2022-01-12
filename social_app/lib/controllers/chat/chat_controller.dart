import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/chat_service.dart';

class ChatController extends GetxController {

  final  storage = const FlutterSecureStorage();
  String ?userId, token;
  String? roomId;

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
    update();
  }

  void onSendTap() async {
    MessageModel message = MessageModel(User.id("618896ed249d4c08b0e85211"), "61af287171f599769ca378fc", messageTextConntroller.text);
    await ChatService.sendMessage(token!, message);
  }
  
}
