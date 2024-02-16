import 'package:dartz/dartz.dart';
import 'package:pemira_app/config/app_constants.dart';
import 'package:pemira_app/config/app_request.dart';
import 'package:pemira_app/config/app_response.dart';
import 'package:pemira_app/config/app_session.dart';
import 'package:pemira_app/config/failure.dart';
import 'package:http/http.dart' as http;

class VoteDatasource {
  static Future<Either<Failure, Map>> getCandidateThisYear() async {
    Uri url = Uri.parse('${AppConstants.baseURL}/get-candidate-by-current-year');

    try {
      final response = await http.post(
        url,
        headers: AppRequest.header(),
        body: {
          'token': await AppSession.getToken(),
          'user_id': (await AppSession.getId()).toString(),
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

  static Future<Either<Failure, Map>> vote(
    String candidateId,
  ) async {
    Uri url = Uri.parse('${AppConstants.baseURL}/vote');

    try {
      final response = await http.post(
        url,
        headers: AppRequest.header(),
        body: {
          'token': await AppSession.getToken(),
          'user_id': (await AppSession.getId()).toString(),
          'candidate_id': candidateId,
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
