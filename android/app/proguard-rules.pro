# TensorFlow Lite core / GPU / NNAPI
-keep class org.tensorflow.lite.** { *; }
-keep class org.tensorflow.lite.gpu.** { *; }
-keep class org.tensorflow.lite.nnapi.** { *; }

# Suppress warnings if any reflection is used internally
-dontwarn org.tensorflow.lite.**
-dontwarn org.tensorflow.lite.gpu.**
