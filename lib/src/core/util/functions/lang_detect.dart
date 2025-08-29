import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';

Future<String> detectLang(String text, {bool firstCharArabic = false}) async {
  // 1) Try on-device ML Kit (mobile)
  try {
    final id = LanguageIdentifier(confidenceThreshold: 0.5);
    final code = await id.identifyLanguage(text);
    await id.close();
    if (code != 'und') return code; // 'und' = undetermined
  } catch (_) {/* ignore and fallback */}
  // 2) Fallback (web/desktop or undetermined)
  // try {
  //   final code = await ld.LanguageDetector.getLanguageCode(content: text);
  //   if (code != null && code.isNotEmpty) return code;
  // } catch (_) {/* ignore */}
  // 3) Last-resort heuristic (your current logic)
  return firstCharArabic ? 'ar' : 'en';
}
