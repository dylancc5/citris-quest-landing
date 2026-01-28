import 'package:supabase_flutter/supabase_flutter.dart';

/// Service for fetching live statistics from Supabase
class StatsService {
  static final StatsService _instance = StatsService._internal();
  factory StatsService() => _instance;
  StatsService._internal();

  // Lazy getter to access Supabase client only when needed
  SupabaseClient? get _supabase {
    try {
      return Supabase.instance.client;
    } catch (e) {
      // Supabase not initialized
      return null;
    }
  }

  // Cache for 5 minutes to reduce DB load
  DateTime? _lastFetchTime;
  int? _cachedTotalScans;
  int? _cachedTotalUsers;

  /// Get total number of scans from the database
  Future<int> getTotalScans() async {
    // Return cached value if still valid
    if (_cachedTotalScans != null &&
        _lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!) <
            const Duration(minutes: 5)) {
      return _cachedTotalScans!;
    }

    // Check if Supabase is initialized
    final client = _supabase;
    if (client == null) {
      return _cachedTotalScans ?? 0;
    }

    try {
      // Use count() with scans PK column (scans has file_name as PK, not id)
      final response = await client
          .from('scans')
          .select('file_name')
          .count(CountOption.exact);

      _cachedTotalScans = response.count;
      _lastFetchTime = DateTime.now();
      return _cachedTotalScans!;
    } catch (e) {
      // If error, return cached value or 0
      return _cachedTotalScans ?? 0;
    }
  }

  /// Get total number of users from the database
  Future<int> getTotalUsers() async {
    // Return cached value if still valid
    if (_cachedTotalUsers != null &&
        _lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!) <
            const Duration(minutes: 5)) {
      return _cachedTotalUsers!;
    }

    // Check if Supabase is initialized
    final client = _supabase;
    if (client == null) {
      return _cachedTotalUsers ?? 0;
    }

    try {
      // Use count() with user_profiles PK column (user_profiles has player_id as PK, not id)
      final response = await client
          .from('user_profiles')
          .select('player_id')
          .count(CountOption.exact);

      _cachedTotalUsers = response.count;
      _lastFetchTime = DateTime.now();
      return _cachedTotalUsers!;
    } catch (e) {
      // If error, return cached value or 0
      return _cachedTotalUsers ?? 0;
    }
  }

  /// Fetch both stats in parallel
  Future<Map<String, int>> getAllStats() async {
    final results = await Future.wait([
      getTotalScans(),
      getTotalUsers(),
    ]);

    return {
      'totalScans': results[0],
      'totalUsers': results[1],
    };
  }

  /// Clear cache (for testing or manual refresh)
  void clearCache() {
    _cachedTotalScans = null;
    _cachedTotalUsers = null;
    _lastFetchTime = null;
  }
}
