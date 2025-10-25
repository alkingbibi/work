// lib/models/search_result.dart

class SearchResult {
  final String primaryName;
  final List<String> otherNames;
  final int confidence;
  final List<Map<String, String>> socialAccounts;
  final List<String> tags;

  SearchResult({
    required this.primaryName,
    required this.otherNames,
    required this.confidence,
    required this.socialAccounts,
    required this.tags,
  });

  // --- START: هذا هو الجزء الذي تم تعديله بالكامل ---
  factory SearchResult.fromFirestore(Map<String, dynamic> data) {
    // نقرأ قائمة الأسماء من الحقل الصحيح 'names'
    final List<String> allNames = List<String>.from(data['names'] ?? []);

    // الاسم الأساسي هو أول اسم في القائمة، أو "اسم غير متوفر" إذا كانت القائمة فارغة
    final String pName = allNames.isNotEmpty ? allNames.first : 'اسم غير متوفر';

    // الأسماء الأخرى هي باقي القائمة (بدون الاسم الأول)
    final List<String> oNames = allNames.length > 1 ? allNames.sublist(1) : [];

    return SearchResult(
      primaryName: pName,
      otherNames: oNames,
      // بما أن هذه الحقول غير موجودة الآن، سنعطيها قيماً افتراضية فارغة
      confidence: data['syncCount'] ?? 0, // يمكننا استخدام syncCount كمؤشر ثقة مبدئي
      socialAccounts: [], // قائمة فارغة حالياً
      tags: [],           // قائمة فارغة حالياً
    );
  }
  // --- END: نهاية الجزء المعدل ---
}
