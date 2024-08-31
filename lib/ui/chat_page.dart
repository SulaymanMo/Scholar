import 'package:flutter/material.dart';
import 'package:scholar/ui/widget/chat_bubble.dart';
import '../constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  static const String route = 'chat_page';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scroll = ScrollController();
  final TextEditingController _controller = TextEditingController();
  final CollectionReference _messages =
      FirebaseFirestore.instance.collection('Messages');

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Scholar Chat',
          style: TextStyle(
            fontFamily: 'Pacifico',
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(logo),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messages.orderBy('time').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    controller: _scroll,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        message: snapshot.data!.docs[index]['message'],
                        isMe: snapshot.data!.docs[index]['id'] == email
                            ? true
                            : false,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Loading ...'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(space),
            child: TextField(
              controller: _controller,
              onSubmitted: (val) {
                _messages.add({
                  'message': val,
                  'time': DateTime.now(),
                  'id': email,
                });
                _controller.clear();
                _scroll.animateTo(
                  _scroll.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastOutSlowIn,
                );
              },
              decoration: InputDecoration(
                hintText: 'Message',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                ),
                suffixIconColor: pColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
