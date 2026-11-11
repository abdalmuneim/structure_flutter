import 'keys.dart';

/// Currently the same server as development (same as lawmate).
class ProductionKeys extends Keys {
  @override
  final String apiUrl = 'https://vcare.integration25.com/api/';

  @override
  final String baseUrl = 'https://vcare.integration25.com';
}
