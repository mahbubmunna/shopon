import 'package:provider/provider.dart';
import 'package:smartcommercebd/src/FlutterProvider/MessageProvider.dart';
import 'package:smartcommercebd/src/models/Conversations.dart';
import 'package:smartcommercebd/src/widgets/EmptyMessagesWidget.dart';
import 'package:smartcommercebd/src/widgets/MessageItemWidget.dart';
import 'package:smartcommercebd/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';

class MessagesWidget extends StatefulWidget {
  @override
  _MessagesWidgetState createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: <Widget>[
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBarWidget(),
            ),*/

            Consumer<MessageProvider>(
              builder: (context, provider, _) {
                return FutureBuilder(
                  future: provider.allConversations(),
                  builder:
                      (context, AsyncSnapshot<Conversations> conversations) {
                    if (conversations.data == null) {
                      return Container(
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      print("Data found");

                      if (conversations.data.results.data != null) {
                        return new ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: conversations.data.results.data.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 7);
                          },
                          itemBuilder: (context, index) {
                            print(
                                "The data is  ${conversations.data.results.data[index]}");

                            //return Container(child: Text("10000"),);
                            return MessageItemWidget(
                              message: conversations.data.results.data[index],
                            );
                          },
                        );
                      } else {
                        return EmptyMessagesWidget();
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
