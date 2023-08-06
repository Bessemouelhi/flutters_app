import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//class service d'authentification
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Connexion avec google
  Future<UserCredential> signInWithGoogle() async {
    // déclenche un flux d'authentification
    final googleUser = await _googleSignIn.signIn().catchError((onError) {
      print('error 1 :');
      print("Error $onError");
    });

    // obtenir les détails d'autorisation de la demande
    final googleAuth = await googleUser!.authentication;

    // créer un nouvel identifiant
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // renvoie l'identifiant de l'utilisateur une fois connecté
    return await _auth.signInWithCredential(credential);
  }

  // renvoie l'état de l'utilisateur en tant réel
  Stream<User?> get user => _auth.authStateChanges();

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _auth.signOut();
  }
}
