import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firestoreinstance = FirebaseFirestore.instance;

class Authentification {
  FirebaseAuth _firebaseAuth;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  Authentification(this._firebaseAuth);
  deconnection() async {
    await _firebaseAuth.signOut();
  }

  enregistrementAuth(String mail, String password, String nom) async {
    try {
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      try {
        await user.user.sendEmailVerification();
        String image, universite, semestre, filiere;
        bool admin = false;
        var utilisateurs = {
          'nom': nom,
          'email': user.user.email,
          'password': password,
          'image': image,
          'universite': universite,
          'semestre': semestre,
          'filiere': filiere,
          'admin': admin,
          'uid': user.user.uid,
        };

        await firestoreinstance
            .collection('Utilisateur')
            .doc(user.user.uid)
            .set(utilisateurs);
        return 'Enregistrement réussi';
      } catch (e) {
        return 'L\'Email est invalide';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Le mot de passe est trop faible, minimum 6 caratères';
      } else if (e.code == 'email-already-in-use') {
        return 'Email existe déjà';
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
      return 'Connexion réussi';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'L\'Email est incorrect';
      } else if (e.code == 'wrong-password') {
        return 'Le mot de passe est incorrect';
      }
    }
  }
}
