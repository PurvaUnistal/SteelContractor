plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "unistal"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    flavorDimensions += "version"

    productFlavors {
        create("prodPBGPL") {
            dimension = "version"
            applicationIdSuffix = ".pbgpl.steel.contractor"
            resValue("string", "app_name", "PBGPL Steel Contractor")
            manifestPlaceholders.put("appIcon", "@mipmap/pbgpl_logo")
            manifestPlaceholders.put("appIconRound", "@mipmap/pbgpl_logo")
            versionCode = 1
            versionName = "1.0.0-PBGPL Contractor"
        }
        create("prodMGL") {
            dimension = "version"
            applicationIdSuffix = ".mgl.steel.contractor"
            resValue("string", "app_name", "MGl Contractor")
            manifestPlaceholders.put("appIcon", "@mipmap/mgl_logo")
            manifestPlaceholders.put("appIconRound", "@mipmap/mgl_logo")
            versionCode = 1
            versionName = "1.0.0-MGL Contractor"
        }
        create("prodUnistal") {
            dimension = "version"
            applicationIdSuffix = ".unistal.steel.contractor"
            resValue("string", "app_name", "Contractor")
            manifestPlaceholders.put("appIcon", "@mipmap/unistal_logo")
            manifestPlaceholders.put("appIconRound", "@mipmap/unistal_logo")
            versionCode = 1
            versionName = "1.0.0-Unistal Contractor"
        }

        create("prodOilIndia") {
            dimension = "version"
            applicationIdSuffix = ".OilIndia.steel.contractor"
            resValue("string", "app_name", "Contractor")
            manifestPlaceholders.put("appIcon", "@mipmap/oil_india_logo")
            manifestPlaceholders.put("appIconRound", "@mipmap/oil_india_logo")
            versionCode = 1
            versionName = "1.0.0-Oil India Contractor"
        }

        create("prodVPPL") {
            dimension = "version"
            applicationIdSuffix = ".vppl.steel.contractor"
            resValue("string", "app_name", "VPPL Contractor")
            manifestPlaceholders.put("appIcon", "@mipmap/vppl_plcms")
            manifestPlaceholders.put("appIconRound", "@mipmap/vppl_plcms")
            versionCode = 1
            versionName = "1.0.0-VPPL Contractor"
        }

        create("prodVRPL") {
            dimension = "version"
            applicationIdSuffix = ".vrpl.steel.contractor"
            resValue("string", "app_name", "VRPL Contractor")
            manifestPlaceholders.put("appIcon", "@mipmap/vrpl_plcms")
            manifestPlaceholders.put("appIconRound", "@mipmap/vrpl_plcms")
            versionCode = 1
            versionName = "1.0.0-VRPL Contractor"
        }

    }


    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "unistal"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24
        targetSdk = 36
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
