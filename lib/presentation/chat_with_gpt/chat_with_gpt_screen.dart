import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatWithGptScreen extends StatefulWidget {
  const ChatWithGptScreen({super.key});

  @override
  State<ChatWithGptScreen> createState() => _ChatWithGptScreenState();
}

class _ChatWithGptScreenState extends State<ChatWithGptScreen> {
  final _openAI = OpenAI.instance.build(
      // token: StringConstants.OPENAI_API_KEY,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true);

  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'Pista', lastName: 'Lee');
  final ChatUser _gptChatUser =
      ChatUser(id: '2', firstName: 'Chat', lastName: 'GPT');

  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with GPT'),
      ),
      body: DashChat(
        typingUsers: _typingUsers,
        currentUser: _currentUser,
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
        messageOptions: const MessageOptions(
            currentUserContainerColor: Colors.black,
            containerColor: Color.fromRGBO(0, 166, 126, 1),
            textColor: Colors.white),
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    // print(m.text);
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });
    List<Messages> _messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    var messagesMapList = _messagesHistory.map((m) {
      return {
        "role": m.role == Role.user ? "user" : "assistant",
        "content": m.content
      };
    }).toList();
    final request = ChatCompleteText(
        model: GptTurbo0301ChatModel(),
        messages: messagesMapList,
        maxToken: 200);
    final response = await _openAI.onChatCompletion(request: request);

    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
              1,
              ChatMessage(
                  user: _gptChatUser,
                  createdAt: DateTime.now(),
                  text: element.message!.content));
        });
      }
    }
    setState(() {
      _typingUsers.remove(_gptChatUser);
    });
  }
}
