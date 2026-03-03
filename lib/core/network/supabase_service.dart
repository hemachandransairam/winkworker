import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  SupabaseClient get client => Supabase.instance.client;

  // Temporary storage for user signup data
  final Map<String, dynamic> _signupData = {};
  String? _currentUserPhone;

  Future<void> setCurrentUserPhone(String phone) async {
    _currentUserPhone = phone;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUserPhone', phone);
  }

  Future<void> initUser() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUserPhone = prefs.getString('currentUserPhone');
  }

  Future<void> logout() async {
    _currentUserPhone = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUserPhone');
    await prefs.setBool(
      'onboarding_shown',
      false,
    ); // Optional: reset onboarding if desired
  }

  String? get currentUserPhone => _currentUserPhone;

  void updateData(Map<String, dynamic> data) {
    _signupData.addAll(data);
  }

  Map<String, dynamic> get signupData => _signupData;

  Future<void> submitApplication() async {
    try {
      // 1. Upload images in parallel and replace local paths with public URLs
      final results = await Future.wait([
        _uploadFileIfLocal(_signupData['profile_photo_url'], 'profile_photos'),
        _uploadFileIfLocal(_signupData['aadhar_url'], 'aadhar_docs'),
        _uploadFileIfLocal(_signupData['license_url'], 'license_docs'),
        _uploadFileIfLocal(_signupData['selfie_url'], 'selfies'),
      ]);

      _signupData['profile_photo_url'] = results[0];
      _signupData['aadhar_url'] = results[1];
      _signupData['license_url'] = results[2];
      _signupData['selfie_url'] = results[3];

      // 2. Insert into the 'workers' table
      await client.from('workers').insert({
        'phone_number': _signupData['phone_number'],
        'full_name': _signupData['full_name'],
        'profile_photo_url': _signupData['profile_photo_url'],
        'experience': _signupData['experience'],
        'aadhar_url': _signupData['aadhar_url'],
        'license_url': _signupData['license_url'],
        'selfie_url': _signupData['selfie_url'],
        'bank_name': _signupData['bank_name'],
        'account_holder_name': _signupData['account_holder_name'],
        'account_number': _signupData['account_number'],
        'branch_name': _signupData['branch_name'],
        'ifsc_code': _signupData['ifsc_code'],
        'status': 'pending',
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Helper to upload a file if the path is a local file path
  Future<String?> _uploadFileIfLocal(dynamic path, String folder) async {
    if (path == null ||
        path is! String ||
        !path.startsWith('/') && !path.contains(':')) {
      return path; // Already a URL or null
    }

    try {
      final file = File(path);
      if (!await file.exists()) return null;

      final extension = path.split('.').last;
      final fileName =
          '$folder/${DateTime.now().millisecondsSinceEpoch}.$extension';

      await client.storage
          .from('worker-assets')
          .upload(
            fileName,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      return client.storage.from('worker-assets').getPublicUrl(fileName);
    } catch (e) {
      print('Error uploading $folder: $e');
      return null;
    }
  }

  Future<void> saveDataLocally() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('offline_worker_data', jsonEncode(_signupData));
      print("Data saved locally due to connection issues.");
    } catch (e) {
      print("Error saving data locally: $e");
    }
  }

  Future<Map<String, dynamic>?> getLocalData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final dataStr = prefs.getString('offline_worker_data');
      if (dataStr != null) {
        return jsonDecode(dataStr) as Map<String, dynamic>;
      }
    } catch (e) {
      print("Error getting local data: $e");
    }
    return null;
  }

  Future<Map<String, dynamic>?> getWorkerData(String phone) async {
    try {
      final response =
          await client
              .from('workers')
              .select()
              .eq('phone_number', phone)
              .maybeSingle();

      if (response != null) return response;

      // If no data in Supabase, try local storage
      return await getLocalData();
    } catch (e) {
      print('Error fetching worker: $e');
      // Fallback to local storage on connection error
      return await getLocalData();
    }
  }

  Future<void> updateWorkerData(String phone, Map<String, dynamic> data) async {
    try {
      await client.from('workers').update(data).eq('phone_number', phone);
    } catch (e) {
      rethrow;
    }
  }
}
