
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:sunbulahome/config/ui_icons.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/FlutterProvider/ChatProvider.dart';
import 'package:sunbulahome/src/FlutterProvider/ProfileProvider/ProfileProvider.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/Chat.dart';
import 'package:sunbulahome/src/utils/common_utils.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatefulWidget {
  final id;

  ChatWidget(this.id);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
/*  ConversationsList _conversationList = new ConversationsList();
  User _currentUser = new User.init().getCurrentUser();*/
  final _myListKey = GlobalKey<AnimatedListState>();
  final myController = TextEditingController();

  ScrollController scrollController;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Messageing Id   ${widget.id}");
    final profile_provider = Provider.of<ProfileProvider>(context);

    /*   final message_provider = Provider.of<MessageProvider>(context);



    print("Length ===>  ${message_provider.chats_list.length}");
*/
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(S.of(context).back),
        centerTitle: false,
      ),
      body: ChangeNotifierProvider<ChatProvider>(
        create: (_) => ChatProvider(widget.id),
        child: Consumer<ChatProvider>(
          builder: (context, chat_provider, _) {
            scrollController = new ScrollController()
              ..addListener(() {
                if (scrollController.position.pixels ==
                    scrollController.position.maxScrollExtent) {
                  // print("Maximum   ${message_provider.}");

                  if (CommonUtils.chat_next_url != null) {
                    chat_provider.chatPagination();
                  }
                }
              });

            return Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: chat_provider.chats_list == null
                      ? Center(
                          child: Text(S.of(context).loading),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: chat_provider.chats_list.length,
                          itemBuilder: (context, int index) {
                            print(
                                "Length=>>>  ${chat_provider.chats_list.length}");

                            if (chat_provider.chats_list.reversed
                                    .toList()[index]
                                    .name ==
                                profile_provider.profile.results.name) {
                              return getSentMessageLayout(chat_provider
                                  .chats_list.reversed
                                  .toList()[index]);
                            } else {
                              return getReceivedMessageLayout(chat_provider
                                  .chats_list.reversed
                                  .toList()[index]);
                            }
                          }),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.10),
                          offset: Offset(0, -4),
                          blurRadius: 10)
                    ],
                  ),
                  child: TextField(
                    controller: myController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: S.of(context).chatTextHere,
                      hintStyle: TextStyle(
                          color: Theme.of(context).focusColor.withOpacity(0.8)),
                      suffixIcon: IconButton(
                        padding: EdgeInsets.only(right: 30),
                        onPressed: () {
                          if (myController.value.text.isNotEmpty) {
                            chat_provider
                                .setMessage(widget.id, myController.value.text)
                                .then((value) {
                              chat_provider.getChat(widget.id);
                              //message_provider.postRefresh;
                            });

                            myController.text = "";
                          }
                        },
                        icon: Icon(
                          UiIcons.cursor,
                          color: Theme.of(context).accentColor,
                          size: 30,
                        ),
                      ),
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                )

                /* Expanded(
                  child: AnimatedList(
                    key: _myListKey,
                    reverse: true,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    initialItemCount: _conversationList.conversations[0].chats.length,
                    itemBuilder: (context, index, Animation<double> animation) {
                      Chat chat = _conversationList.conversations[0].chats[index];
                      return ChatMessageListItem(
                        chat: chat,
                        animation: animation,
                      );
                    },
                  ),
                ),*/
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getSentMessageLayout(ChatData chat) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).focusColor.withOpacity(0.2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new Flexible(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(chat.name, style: Theme.of(context).textTheme.body2),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(chat.message),
                  ),
                ],
              ),
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    child: chat.image == null
                        ? Icon(
                            Icons.perm_identity,
                          )
                        : CachedNetworkImageProvider("${public_path_url}${chat.image}"))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getReceivedMessageLayout([ChatData chat]) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    child: chat.image == null
                        ? Icon(
                            Icons.perm_identity,
                          )
                        : CachedNetworkImageProvider("${public_path_url}${chat.image}"))
              ],
            ),
            new Flexible(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(chat.name,
                      style: Theme.of(context).textTheme.body2.merge(
                          TextStyle(color: Theme.of(context).primaryColor))),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(
                      chat.message,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
