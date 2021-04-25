import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret/model/user.dart';
import 'package:secret/provider/feedback_position_provider.dart';

class UserCardWidget extends StatelessWidget {
  final User user;
  final bool isUserInFocus;

  const UserCardWidget({
    @required this.user,
    @required this.isUserInFocus,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedbackPositionProvider>(context);
    final swipingDirection = provider.swipingDirection;
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.86,
      width: size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(user.imgUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 0.5),
          ],
          gradient: LinearGradient(
            colors: [Color(0x2F021420), Color(0xFF021420)],
            begin: Alignment.center,
            stops: [0.4, 1],
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 10,
              left: 10,
              bottom: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildUserInfo(user: user),
                  Padding(
                      padding: EdgeInsets.only(bottom: 16, right: 8),
                      child: ButtonBar(children: [
                        Icon(Icons.favorite, color: Color(0xFFFF4A71)),
                        Text(
                          '${user.likes}',
                          style: TextStyle(
                            color: Color(0xFFF8F8F8),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ]))
                ],
              ),
            ),
            if (isUserInFocus) buildLikeBadge(swipingDirection)
          ],
        ),
      ),
    );
  }

  Widget buildLikeBadge(SwipingDirection swipingDirection) {
    final isSwipingRight = swipingDirection == SwipingDirection.right;
    final color = isSwipingRight ? Color(0xFFFF4A71) : Color(0xFF021420);
    final angle = isSwipingRight ? -0.5 : 0.5;

    if (swipingDirection == SwipingDirection.none) {
      return Container();
    } else {
      return Positioned(
        top: 20,
        right: isSwipingRight ? null : 20,
        left: isSwipingRight ? 20 : null,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              isSwipingRight ? 'Like' : 'Next',
              style: TextStyle(
                color: Color(0xFFF8F8F8),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                backgroundColor: color,
              ),
            ),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          ),
        ),
      );
    }
  }

  Widget buildUserInfo({@required User user}) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${user.workPlace}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${user.gender}, ${user.age} Tahun',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 4),
          ],
        ),
      );
}
