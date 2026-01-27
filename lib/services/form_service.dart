import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service for submitting contribution forms to Supabase
class FormService {
  final _supabase = Supabase.instance.client;

  /// Submit a contribution to the contributions table
  /// Returns true if successful, false otherwise
  Future<bool> submitContribution({
    required String name,
    required String email,
    required String contributionType,
    required String message,
  }) async {
    try {
      await _supabase.from('contributions').insert({
        'name': name,
        'email': email,
        'contribution_type': contributionType,
        'message': message,
        // status defaults to 'pending' in database
      });
      return true;
    } catch (e) {
      debugPrint('Form submission error: $e');
      return false;
    }
  }
}
