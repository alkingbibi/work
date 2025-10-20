// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/search_result.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<SearchResult?> searchNumber(String number) async {
        final cleanNumber = number.replaceAll(RegExp(r'[^0-9]'), '');
            if (cleanNumber.isEmpty) return null;

                final docSnapshot = await _firestore.collection('numbers').doc(cleanNumber).get();

                    if (docSnapshot.exists) {
                          return SearchResult.fromFirestore(docSnapshot.data()!);
                              } else {
                                    return null;
                                        }
                                          }
                                          }
                                          