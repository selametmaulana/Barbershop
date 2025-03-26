plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // Firebase
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.flutter_barbershop"
    compileSdk = 34  // Gantilah dengan angka, bukan variabel flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // Pastikan satu kali deklarasi

    defaultConfig {
        applicationId = "com.example.flutter_barbershop"
        minSdk = 21  // Sesuaikan dengan kebutuhan aplikasi
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // Sesuaikan jika ada keperluan signing
        }
    }
}

flutter {
    source = "../.."
}
