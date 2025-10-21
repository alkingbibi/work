        import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_app/screens/search_screen.dart';
import 'package:temp_app/services/contacts_service.dart';
import 'package:temp_app/services/permissions_service.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final PermissionsService _permissionsService = PermissionsService();
  final ContactsService _contactsService = ContactsService();
  bool _isFirstTime = true;
  bool _isChecking = true;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    // Use `?? true` to default to true if the key doesn't exist.
    final isFirst = prefs.getBool('isFirstTime') ?? true;

    if (mounted) {
      setState(() {
        _isFirstTime = isFirst;
        _isChecking = false;
      });
    }
  }

  Future<void> _handleSync() async {
    if (mounted) {
      setState(() {
        _isSyncing = true;
      });
    }

    // This is the function that might be failing.
    // We will call it without arguments as we discovered.
    await _contactsService.syncContacts();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
    }
  }

  Future<void> _handleSkip() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false); // Mark as not first time
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      // Show a loading indicator while checking SharedPreferences
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_isFirstTime) {
      // If not the first time, go directly to the main screen
      return const SearchScreen();
    }

    // This is the first time, show the sync screen
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.sync, color: Colors.white, size: 80),
              const SizedBox(height: 20),
              const Text(
                'مزامنة لمرة واحدة',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 15),
              const Text(
                'يعتمد يماني كاشف على المساهمة المجتمعية. يرجى المزامنة للمساعدة في بناء قاعدة البيانات.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 40),
              if (_isSyncing)
                const CircularProgressIndicator(
                  color: Colors.white,
                )
              else
                // The Row with our two new buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // "Agree" Button
                    ElevatedButton(
                      onPressed: _handleSync,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                      ),
                      child: const Text('موافق'),
                    ),
                    const SizedBox(width: 20),
                    // "Not Now" Button
                    TextButton(
                      onPressed: _handleSkip,
                      child: const Text(
                        'ليس الآن',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
