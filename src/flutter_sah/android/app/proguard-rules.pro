# Flutter / Gradle defaults
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# flutter_local_notifications — usa Gson com generics em runtime para serializar
# a lista de notificações agendadas; sem manter os tipos genéricos o R8 quebra
# com "Missing type parameter." em release.
-keep class com.dexterous.** { *; }
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Mantém modelos de notificação serializados pelo Gson
-keep class com.dexterous.flutterlocalnotifications.models.** { *; }

# Tira aviso de classes do Gson que dependem de sun.misc
-dontwarn sun.misc.**
-dontwarn com.google.errorprone.annotations.**
