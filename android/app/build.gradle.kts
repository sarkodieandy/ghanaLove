plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // Flutter plugin last
}

android {
    namespace = "com.example.ghconnect"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13113456"

    defaultConfig {
        applicationId = "com.example.ghconnect"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true // ✅ Enables Java 8+ APIs
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ Required for flutter_local_notifications and modern APIs
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
