import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return FirebaseOptions(
      apiKey: "AIzaSyCVYeaFGRsYRXhQmfqFe4mal2EgHgEXebQ", // Ganti dengan API key yang benar
      authDomain: "barbershop-55721.firebaseapp.com",
      projectId: "barbershop-55721",
      storageBucket: "barbershop-55721.firebasestorage.app",
      messagingSenderId: "964017687963",
      appId: "1:964017687963:web:34da5dff82e96ae560653e",
      measurementId: "G-45B1T5GMT8", // Jika ada
    );
  }
}

