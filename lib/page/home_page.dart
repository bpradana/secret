import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret/data/users.dart';
import 'package:secret/model/user.dart';
import 'package:secret/provider/feedback_position_provider.dart';
import 'package:secret/widget/bottom_buttons_widget.dart';
import 'package:secret/widget/user_card_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<User> users = dummyUsers;

  @override
  Widget build(BuildContext context) => Scaffold(
        
        appBar: buildAppBar(),
        backgroundColor: Color(0xff131418),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              users.isEmpty
                  ? Text('Konten habis')
                  : Stack(children: users.map(buildUser).toList()),
              Expanded(child: Container()),
              BottomButtonsWidget()
            ],
          ),
        ),
      );

  Widget buildAppBar() => AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: TextButton.icon(
          icon: ImageIcon(
            AssetImage('assets/icons/icon_logo.png'),
            size: 32,
          ),
          label: Text(
            'deepTalk',
            style: TextStyle(
              fontFamily: 'SourceSansPro',
              color: Color(0xFFEAEAEA),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          onPressed: () {
            print('Pressed');
          }
          )
  );
      

  Widget buildUser(User user) {
    final userIndex = users.indexOf(user);
    final isUserInFocus = userIndex == users.length - 1;

    return Listener(
      onPointerMove: (pointerEvent) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.updatePosition(pointerEvent.localDelta.dx);
      },
      onPointerCancel: (_) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      onPointerUp: (_) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      child: Draggable(
        child: UserCardWidget(user: user, isUserInFocus: isUserInFocus),
        feedback: Material(
          type: MaterialType.transparency,
          child: UserCardWidget(user: user, isUserInFocus: isUserInFocus),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) => onDragEnd(details, user),
      ),
    );
  }

  void onDragEnd(DraggableDetails details, User user) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      user.isSwipedOff = true;
    } else if (details.offset.dx < -minimumDrag) {
      user.isLiked = true;
    }

    setState(() => users.remove(user));
  }
}
