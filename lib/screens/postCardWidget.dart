import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostCardWidget extends StatelessWidget {
  final String imageUrl;
  final FirebaseUser user;

  PostCardWidget({@required this.user,@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Card(
      child: Column(
        children: <Widget>[
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
             children: <Widget>[
               CircleAvatar(
                 backgroundImage: NetworkImage(user.photoUrl),
                 radius: 20.0,
               ),
                SizedBox(width: 10.0,),
                Text(user.displayName),
             ],
           ),
         ),
          Image.network(imageUrl,width: deviceWidth,height: deviceHeight/3,fit: BoxFit.fill,),
          Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.favorite), onPressed: (){}),
              IconButton(icon: Icon(Icons.comment), onPressed: (){}),
              IconButton(icon: Icon(Icons.share), onPressed: (){}),
            ],
          ),
        ],
      ),
    );
  }
}
