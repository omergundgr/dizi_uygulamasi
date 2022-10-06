//anonymous authentication
import 'package:firebase_auth/firebase_auth.dart';

Future firebaseAuth() async => await FirebaseAuth.instance.signInAnonymously();
