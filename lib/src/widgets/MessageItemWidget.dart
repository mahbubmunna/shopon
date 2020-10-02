import 'package:sunbulahome/config/ui_icons.dart';
import 'package:sunbulahome/src/models/Conversations.dart';
import 'package:sunbulahome/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:sunbulahome/src/screens/chat.dart';

class MessageItemWidget extends StatefulWidget {
  MessageItemWidget({
    Key key,
    this.message,
  }) : super(key: key);
  Data message;

  @override
  _MessageItemWidgetState createState() => _MessageItemWidgetState();
}

class _MessageItemWidgetState extends State<MessageItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this.widget.message.hashCode.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              UiIcons.trash,
              color: Colors.white,
            ),
          ),
        ),
      ),
      /*   onDismissed: (direction) {
        // Remove the item from the data source.


        // Then show a snackbar.
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("The conversation with ${widget.message.user.name} is dismissed")));
      },*/
      child: InkWell(
        onTap: () {
          //Navigator.of(context).pushNamed('/Tabs', arguments: 5);

          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => ChatWidget(widget.message.id)));
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            color: Theme.of(context).focusColor.withOpacity(0.15),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xff00B8C5),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(
                        Icons.perm_identity,
                        color: Colors.white,
                      ),
                    ),
                    /*   Positioned(
                      bottom: 3,
                      right: 3,
                      width: 12,
                      height: 12,
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.message.user.userState == UserState.available
                              ? Colors.green
                              : widget.message.user.userState == UserState.away ? Colors.orange : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )*/
                  ],
                ),
                SizedBox(width: 15),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      /* Text(
                        this.widget.message.,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.body2,
                      ),*/

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            this.widget.message.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .merge(TextStyle(fontWeight: FontWeight.w600)),
                          ),
                          Text(
                            this.widget.message.createdAt,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .merge(TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      Text(
                        this.widget.message.lastMessage,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
