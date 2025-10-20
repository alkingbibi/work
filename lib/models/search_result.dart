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

                                    // دالة لتحويل البيانات القادمة من Firebase إلى هذا النموذج
                                      factory SearchResult.fromFirestore(Map<String, dynamic> data) {
                                          return SearchResult(
                                                primaryName: data['primaryName'] ?? 'اسم غير متوفر',
                                                      otherNames: List<String>.from(data['otherNames'] ?? []),
                                                            confidence: data['confidence'] ?? 0,
                                                                  socialAccounts: List<Map<String, String>>.from(
                                                                            (data['socialAccounts'] ?? []).map((item) => Map<String, String>.from(item))
                                                                                  ),
                                                                                        tags: List<String>.from(data['tags'] ?? []),
                                                                                            );
                                                                                              }
                                                                                              }
                                                                                              