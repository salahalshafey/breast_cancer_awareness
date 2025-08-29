import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.example.breast_cancer_awareness"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // Keep TFLite files uncompressed in APK/AAB
    aaptOptions {
        noCompress("tflite")
        noCompress("lite")
    }

    compileOptions {
        // Java 11 + desugaring (to use newer Java APIs on older Android)
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.salahalshafey.breastcancerawareness"
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"]?.toString()
            keyPassword = keystoreProperties["keyPassword"]?.toString()
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"]?.toString()
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")

            // Enable code shrinking/obfuscation for release
            isMinifyEnabled = true
            // (optional) also shrink unused resources
            // isShrinkResources = true

            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro" // <— the file you created in step 1
            )
        }
    }

    lint {
        disable.add("InvalidPackage")
        disable.add("Instantiatable")
        checkReleaseBuilds = false
        abortOnError = false
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.window:window:1.0.0")
    implementation("androidx.window:window-java:1.0.0")

    // TensorFlow Lite GPU nightly (keep only if you really need nightly)
    // implementation("org.tensorflow:tensorflow-lite-gpu:0.0.0-nightly")

    // Desugar JDK libs for Java 11 APIs on older Android
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:1.2.2")

    // Facebook SDK 8.x
    implementation("com.facebook.android:facebook-android-sdk:[8,9)")
}
