import 'dart:developer';

void handleException(dynamic jsonData) {
  if (jsonData != null && jsonData is Map<String, dynamic>) {
    if (jsonData.containsKey('status_code')) {
      final statusCode = jsonData['status_code'];
      final message = jsonData['message']?.toString() ?? 'An error occurred';

      if (statusCode != 200) {
        log('API Error: Status Code - $statusCode, Message - $message');
        // You can add more specific error handling based on status codes
        if (statusCode == 400) {
          // Bad Request
          log('API Bad Request: $message');
          // Optionally throw a custom exception
          throw BadRequestException(message);
        } else if (statusCode == 401) {
          // sessionExpired(context, msg);
          // Unauthorized
          log('API Unauthorized: $message');
          // Optionally handle token refresh or logout
          throw UnauthorizedException(message);
        } else if (statusCode == 404) {
          // Not Found
          log('API Not Found: $message');
          throw NotFoundException(message);
        } else if (statusCode >= 500) {
          // Server Error
          log('API Server Error ($statusCode): $message');
          throw ServerErrorException(message);
        } else {
          // Other error codes
          throw ApiException('API Error ($statusCode): $message');
        }
      } else {
        // Status code is 200, but you might want to check for specific error messages within the data
        if (jsonData.containsKey('error') && jsonData['error'] != null) {
          final errorMessage = jsonData['error'].toString();
          log('API Success with Error: $errorMessage');
          throw ApiException('API Success with Error: $errorMessage');
        }
        // You can add checks for other error indicators in your success response if needed
      }
    } else if (jsonData.containsKey('error')) {
      // Handle cases where the top-level key is 'error'
      final errorMessage = jsonData['error'].toString();
      log('API Error: $errorMessage');
      throw ApiException('API Error: $errorMessage');
    }
    // Add more checks for different error structures your API might return
  } else {
    log('API Response format is unexpected: $jsonData');
    throw ApiException('Unexpected API response format');
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() {
    return 'ApiException: $message';
  }
}

class BadRequestException extends ApiException {
  BadRequestException(super.message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message);
}

class NotFoundException extends ApiException {
  NotFoundException(super.message);
}

class ServerErrorException extends ApiException {
  ServerErrorException(super.message);
}
