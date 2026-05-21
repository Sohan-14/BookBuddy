import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

abstract interface class NetworkInfo {
  /// One-time connectivity check
  Future<bool> get isConnected;

  /// Stream of connectivity changes
  Stream<bool> get onConnectivityChanged;

  Future<ConnectivityResult> get connectivityType;
}

class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    try {
      final result = await _connectivity.checkConnectivity();
      final hasConnection = result.any(
        (status) => status != ConnectivityResult.none,
      );

      if (hasConnection) {
        return await _verifyInternetAccess();
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged
        .map(
          (result) => result.any((s) => s != ConnectivityResult.none),
        )
        .asyncMap((hasConnection) async {
          if (hasConnection) {
            return _verifyInternetAccess();
          }
          return false;
        })
        .distinct();
  }

  @override
  Future<ConnectivityResult> get connectivityType async {
    final result = await _connectivity.checkConnectivity();
    return result.firstOrNull ?? ConnectivityResult.none;
  }

  /// Verify actual internet access by pinging a reliable server
  Future<bool> _verifyInternetAccess() async {
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 3),
          receiveTimeout: const Duration(seconds: 2),
        ),
      );

      // Use Google's lightweight endpoint that returns 204 No Content
      // This is reliable, fast, and doesn't consume bandwidth
      final response = await dio.head<dynamic>(
        'https://clients3.google.com/generate_204',
        queryParameters: {'t': DateTime.now().millisecondsSinceEpoch},
      );
      return response.statusCode == 204 || response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
