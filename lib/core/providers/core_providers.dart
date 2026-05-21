import 'package:book_buddy/core/network/dio_client.dart';
import 'package:book_buddy/core/network/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'core_providers.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) => createDioClient();

@Riverpod(keepAlive: true)
Connectivity connectivity(Ref ref) => Connectivity();

@Riverpod(keepAlive: true)
NetworkInfo networkInfo(Ref ref) =>
    NetworkInfoImpl(ref.watch(connectivityProvider));
