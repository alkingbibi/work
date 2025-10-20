// lib/services/contacts_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<void> syncContacts() async {
        // التأكد من أن لدينا إذن قبل القراءة
            if (await FlutterContacts.requestPermission()) {
                  List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);

                        WriteBatch batch = _firestore.batch();

                              for (var contact in contacts) {
                                      if (contact.phones.isNotEmpty && contact.displayName.isNotEmpty) {
                                                for (var phone in contact.phones) {
                                                            String cleanNumber = phone.number.replaceAll(RegExp(r'[^0-9]'), '');
                                                                        if (cleanNumber.length > 7) { // تجاهل الأرقام القصيرة جدًا
                                                                                      final docRef = _firestore.collection('numbers').doc(cleanNumber);
                                                                                                    batch.set(
                                                                                                                    docRef,
                                                                                                                                    {
                                                                                                                                                      'names': FieldValue.arrayUnion([contact.displayName]),
                                                                                                                                                                        'syncCount': FieldValue.increment(1),
                                                                                                                                                                                        },
                                                                                                                                                                                                        SetOptions(merge: true),
                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                // تنفيذ كل عمليات الكتابة دفعة واحدة
                                                                                                                                                                                                                                                                      await batch.commit();
                                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                                            