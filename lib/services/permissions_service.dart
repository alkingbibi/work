// lib/services/permissions_service.dart

import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Future<bool> requestContactsPermission() async {
      var status = await Permission.contacts.status;
          if (status.isDenied) {
                // إذا كان الإذن مرفوضًا، نطلبه من المستخدم
                      final result = await Permission.contacts.request();
                            return result.isGranted;
                                }
                                    if (status.isPermanentlyDenied) {
                                          // إذا رفضه بشكل دائم، نفتح إعدادات التطبيق
                                                openAppSettings();
                                                      return false;
                                                          }
                                                              // إذا كان الإذن ممنوحًا بالفعل
                                                                  return true;
                                                                    }
                                                                    }
                                                                    