import 'package:firebase_auth/firebase_auth.dart';

class Authentification {
  FirebaseAuth _firebaseAuth;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  Authentification(this._firebaseAuth);
  enregistrementAuth(String mail, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      return 'Signed UP';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
      return 'erreur';
    }
  }

  connection(String mail, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: password);
      return 'Signed In';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }
}

// enregistrementAuth(String mail, String password) async {
//     try {
//       UserCredential userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: mail,
//         password: password,
//       );
//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//         return 'weak';
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//         return 'Exist';
//       }
//     } catch (e) {
//       print(e);
//       return 'erreur';
//     }
//   }

//   connection(String mail, String password) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: mail, password: password);
//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//         return 'NotExist';
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//         return 'Password erreur';
//       }
//     }
//   }
