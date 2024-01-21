import 'package:dartz/dartz.dart';
import 'package:pemira_app/config/app_constants.dart';
import 'package:pemira_app/config/app_request.dart';
import 'package:pemira_app/config/app_response.dart';
import 'package:pemira_app/config/failure.dart';
import 'package:http/http.dart' as http;

class ElectionFraudDatasource {
  static Future<Either<Failure, Map>> reportFraud(
    String token,
    int userId,
    String date,
    String description,
    String password,
  ) async {
    Uri url = Uri.parse('${AppConstants.baseURL}/report-fraud');

    try {
      final response = await http.post(
        url,
        headers: AppRequest.header(),
        body: {
          'token': token,
          'user_id': userId.toString(),
          'date': date,
          'description': description,
          'password': password,
        },
      );

      final data = AppResponse.data(response);

      return Right(data);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }

      return Left(FetchFailure(message: e.toString()));
    }
  }
}
