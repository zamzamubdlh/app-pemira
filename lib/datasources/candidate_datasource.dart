import 'dart:io';
import 'package:path/path.dart';
import 'package:dartz/dartz.dart';
import 'package:pemira_app/config/app_constants.dart';
import 'package:pemira_app/config/app_request.dart';
import 'package:pemira_app/config/app_response.dart';
import 'package:pemira_app/config/app_session.dart';
import 'package:pemira_app/config/failure.dart';
import 'package:http/http.dart' as http;

class CandidateDatasource {
  static Future<Either<Failure, Map>> registerCandidate(
    String age,
    String programStudy,
    String shortDescription,
    String vision,
    String mission,
    String photo,
    String reasonForChoice,
    String name,
  ) async {
    Uri url = Uri.parse('${AppConstants.baseURL}/register-candidate');

    try {
      final response = await http.post(
        url,
        headers: AppRequest.header(),
        body: {
          'token': await AppSession.getToken(),
          'user_id': (await AppSession.getId()).toString(),
          'age': age,
          'program_study': programStudy,
          'short_description': shortDescription,
          'vision': vision,
          'mission': mission,
          'name': name,
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

  static Future<Either<Failure, Map>> listPreviousVote() async {
    Uri url = Uri.parse('${AppConstants.baseURL}/list-previous-votes');

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
}
