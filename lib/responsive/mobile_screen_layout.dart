import 'package:c_insta/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:c_insta/models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    //항상 user 사용할때 firebase auth의 user를 가져오는지, 아니면 내가 만든 user인지 확인
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: Center(child: Text(user.email)),
    );
  }
}

  // String username = "";

  // @override
  // void initState() {
  //   super.initState();
  //   getUsername();
  // }

  // void getUsername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   setState(() {
  //     // 스냅샷 데이터를 바로 가져오려고 하면 실패한다.
  //     // username = snap.data()!['username'];

  //     // 스냅샷 데이터를 맵형식으로 바꾼뒤, <원하는타입, dynamic> ['원하는 key']로 가져온다.
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });

  //   print(username);
  // }