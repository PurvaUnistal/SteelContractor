import java.util.Properties
import java.io.FileInputStream
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}
val keystoreProperties = Properties()

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
            applicationIdSuffix = ".pbgpl.steel.approver"
            resValue("string", "app_name", "PBGPL Approver")
            manifestPlaceholders.put("appIcon", "@mipmap/pbgpl_logo")
            manifestPlaceholders.put("appIconRound", "@mipmap/pbgpl_logo")
            versionCode = 1
            versionName = "1.0.0-PBGPL Approver"
        }
        create("prodMGL") {
            dimension = "version"
            applicationIdSuffix = ".mgl.steel.approver"
            resValue("string", "app_name", "MGl Approver")
            manifestPlaceholders.put("appIcon", "@mipmap/mgl_logo")
            manifestPlaceholders.put("appIconRound", "@mipmap/mgl_logo")
            versionCode = 1
            versionName = "1.0.0-MGL Approver"
        }
        create("prodUnistal") {
            dimension = "version"
            applicationIdSuffix = ".unistal.steel.approver"
            resValue("string", "app_name", "Approver")
            manifestPlaceholders.put("appIcon", "@mipmap/unistal_logo")
            manifestPlaceholders.put("appIconRound", "@mipmap/unistal_logo")
            versionCode = 1
            versionName = "1.0.0-Unistal Approver"
        }

        create("prodOilIndia") {
            dimension = "version"
            applicationIdSuffix = ".OilIndia.steel.approver"
            resValue("string", "app_name", "HP OIL Approver")
            manifestPlaceholders.put("appIcon", "@mipmap/oil_india_logo")
            manifestPlaceholders.put("appIconRound", "@mipmap/oil_india_logo")
            versionCode = 1
            versionName = "1.0.0-HPOIL Approver"
        }

        create("prodHPOIL") {
            dimension = "version"
            applicationIdSuffix = ".hpoil.steel.approver"
            resValue("string", "app_name", "HPOIL Approver")
            manifestPlaceholders.put("appIcon", "@mipmap/unistal_logo")
            manifestPlaceholders.put("appIconRound", "@mipmap/unistal_logo")
            versionCode = 1
            versionName = "1.0.0-HPOIL"
            val keystorePropertiesFile = rootProject.file("hpoil.properties")
            if (keystorePropertiesFile.exists()) {
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))
            }
        }

        create("prodVPPL") {
            dimension = "version"
            applicationIdSuffix = ".vppl.steel.approver"
            resValue("string", "app_name", "VPPL Approver")
            manifestPlaceholders.put("appIcon", "@mipmap/vppl_plcms")
            manifestPlaceholders.put("appIconRound", "@mipmap/vppl_plcms")
            versionCode = 1
            versionName = "1.0.0-VPPL Approver"
        }

        create("prodVRPL") {
            dimension = "version"
            applicationIdSuffix = ".vrpl.steel.approver"
            resValue("string", "app_name", "VRPL Approver")
            manifestPlaceholders.put("appIcon", "@mipmap/vrpl_plcms")
            manifestPlaceholders.put("appIconRound", "@mipmap/vrpl_plcms")
            versionCode = 2
            versionName = "1.0.0-VRPL Approver"
            val keystorePropertiesFile = rootProject.file("vrpl.properties")
            if (keystorePropertiesFile.exists()) {
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))
            }
        }
        create("prodJDPL") {
            dimension = "version"
            applicationIdSuffix = ".jdpl.steel.approver"
            resValue("string", "app_name", "JDPL Approver")
            manifestPlaceholders.put("appIcon", "@mipmap/unistal_logo")
            manifestPlaceholders.put("appIconRound", "@mipmap/unistal_logo")
            versionCode = 2
            versionName = "1.0.0-JDPL"
            val keystorePropertiesFile = rootProject.file("jdpl.properties")
            if (keystorePropertiesFile.exists()) {
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))
            }
        }
        create("prodBRCPL") {
            dimension = "version"
            applicationIdSuffix = ".brcpl.steel.approver"
            resValue("string", "app_name", "BCPL Approver")
            manifestPlaceholders.put("appIcon", "@mipmap/vrpl_plcms")
            manifestPlaceholders.put("appIconRound", "@mipmap/vrpl_plcms")
            versionCode = 5
            versionName = "1.0.0-BCPL"
            val keystorePropertiesFile = rootProject.file("brcpl.properties")
            if (keystorePropertiesFile.exists()) {
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))
            }
        }

        create("prodAGCL") {
            dimension = "version"
            applicationIdSuffix = ".agcl.steel.approver"
            resValue("string", "app_name", "AGCL Approver")
            manifestPlaceholders.put("appIcon", "@mipmap/agcl_logo")
            manifestPlaceholders.put("appIconRound", "@mipmap/agcl_logo")
            versionCode = 1
            versionName = "1.0.0-AGCL"
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
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
dependencies {
    implementation("com.google.android.play:app-update:2.1.0")
    implementation("com.google.android.play:app-update-ktx:2.1.0")
    implementation(platform("com.google.firebase:firebase-bom:33.11.0"))
}