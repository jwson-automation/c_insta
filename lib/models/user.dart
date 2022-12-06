import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "photoUrl": photoUrl,
        "username": username,
        "bio": bio,
        "followers": followers,
        "following": following,
      };

  // for provider
  // 원래라면 아래와 같이 데이터를 가져올때 하나씩 맵 데이터라 가져와줘야한다.
  // model.User(
  //     followers: (snap.data() as Map<String, dynamic>)['followers']);
  // 하지만 아래 static을 만들어주면 그냥 가져와서 바로 쓸 수 있다!
  // 리팩토링의 개념!
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      email: snapshot['email'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl'],
      username: snapshot['username'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
