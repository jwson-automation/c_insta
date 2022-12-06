import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// firebase_auth에서도 User라는 클래스가 존재해서, as model을 붙여준다.
import '../models/user.dart' as model;
import 'storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // 유저모델에서 가져오기
        model.User user = model.User(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );

        //user 모델을 이용하면 하나로 정리가능, 여기에서 Map 데이터로 변환이 필요하기 때문에
        //toJson이라는 함수를 User Model 파일안에 미리 만들어 준것
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        //add user to our database
        //User 모델이 없을때 직접 지정해서 가져오는 방법
        // await _firestore.collection('users').doc(cred.user!.uid).set({
        //   'email': email,
        //   'uid': cred.user!.uid,
        //   'photoUrl': photoUrl,
        //   'username': username,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        // set --> add 가 되면,
        // 없는 스토리지를 생성하지 못하기 때문에 오류가 발생한다.

        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });
        res = "success";
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = 'The email is badly formatted.';
    //   } else if (err.code == 'weak-password') {
    //     res = 'Password should be at least 6 characters.';
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

//로그인
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
