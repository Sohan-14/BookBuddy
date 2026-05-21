class ApiConstants {
  const ApiConstants._();

  static const String volumesEndpoint = '/volumes';

  static String fixThumbnailUrl(String url) =>
      url.replaceFirst('http://', 'https://');
}
