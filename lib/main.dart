// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'screens/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
          );
            runApp(const YamaniCashefApp());
            }

            class YamaniCashefApp extends StatelessWidget {
              const YamaniCashefApp({super.key});

                @override
                  Widget build(BuildContext context) {
                      return MaterialApp(
                            title: 'يماني كاشف',
                                  debugShowCheckedModeBanner: false,
                                        theme: ThemeData(
                                                textTheme: GoogleFonts.tajawalTextTheme(
                                                          Theme.of(context).textTheme,
                                                                  ),
                                                                          scaffoldBackgroundColor: const Color(0xFFF0F2F5),
                                                                                  appBarTheme: const AppBarTheme(
                                                                                            backgroundColor: Color(0xFFF0F2F5),
                                                                                                      elevation: 0,
                                                                                                                centerTitle: true,
                                                                                                                          titleTextStyle: TextStyle(
                                                                                                                                      fontFamily: 'Tajawal',
                                                                                                                                                  color: Color(0xFF1D2D44),
                                                                                                                                                              fontSize: 22,
                                                                                                                                                                          fontWeight: FontWeight.bold,
                                                                                                                                                                                    ),
                                                                                                                                                                                            ),
                                                                                                                                                                                                  ),
                                                                                                                                                                                                        locale: const Locale('ar'),
                                                                                                                                                                                                              // نقطة البداية الآن هي بوابة المصادقة
                                                                                                                                                                                                                    home: const AuthGate(),
                                                                                                                                                                                                                        );
                                                                                                                                                                                                                          }
                                                                                                                                                                                                                          }
                                                                                                                                                                                                                          