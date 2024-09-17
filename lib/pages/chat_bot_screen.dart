import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:uuid/uuid.dart';



import '../controllers/user_controller.dart';
import '../widgets/custom_drawer_nav.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  bool isOpened = false;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  toggleMenu([bool end = false]) {
    if (end) {
      final state = _endSideMenuKey.currentState!;
      if (state.isOpened) {
        state.closeSideMenu();
      } else {
        state.openSideMenu();
      }
    } else {
      final state = _sideMenuKey.currentState!;
      if (state.isOpened) {
        state.closeSideMenu();
      } else {
        state.openSideMenu();
      }
    }
  }

  final List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  UserController userController = Get.put(UserController());

  @override
  void initState() {
    userController.subscribeToUserChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: const Color(0xffffffff),
      key: _sideMenuKey,
      menu: const Nav(),
      type: SideMenuType.slideNRotate,
      onChange: (isOpened) {
        setState(() => isOpened = isOpened);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(children: [
            SizedBox(
              width: 140.w,
              height: 26.h,
              child: Text(
                userController.user.value!.businessName!,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.2575.h,
                  color: const Color(0xff000000),
                ),
              ),
            ),
            SizedBox(
              width: 189.w,
              height: 16.h,
              child: Text(
                'Home Cook • Fast food • Local • Wines',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.6.h,
                  color: const Color(0xff797878),
                ),
              ),
            ),
          ]),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
            ),
            onPressed: () {
              toggleMenu();
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5.w, 0),
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: CachedNetworkImage(
                placeholder: (context, url) => const AspectRatio(
                  aspectRatio: 1.6,
                  child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                ),
                imageUrl: userController.user.value!.logoDownloadURL!,
                fit: BoxFit.fill,
              ),
            ),
          ],
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(userController.user.value!
                        .downloadURL!), // Replace with your background image asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: Colors.white
                    .withOpacity(0.7), // Adjust the opacity as needed
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Chat(
            messages: _messages,
            onSendPressed: _handleSendPressed,
            user: _user,
          ),
        ),
      ),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }
}
