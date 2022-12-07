import 'dart:typed_data';

import 'package:c_insta/models/post.dart' as model;
import 'package:c_insta/resouces/storage_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      model.Post post = model.Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

// Future<void> likePost(String postId, String uid, List likes) async {
//   try {
//     if (likes.contains.uid) {
//       _firestore.collection('posts').document(postId).update({

//       });
//     }
//   } catch (e) {
//     print(
//       e.toString(),
//     );
//   }
// }
