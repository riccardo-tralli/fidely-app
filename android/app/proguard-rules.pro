# Keep OkHttp classes for UCrop (used by image_cropper) [https://github.com/hnvn/flutter_image_cropper/issues/593]
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**
-keep class com.yalantis.ucrop.** { *; }
-dontwarn com.yalantis.ucrop.**