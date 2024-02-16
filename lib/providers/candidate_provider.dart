import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d_method/d_method.dart';
import 'package:pemira_app/models/candidate_model.dart';

final registerCandidateStatusProvider = StateProvider.autoDispose((ref) => '');

setRegisterCandidateStatus(WidgetRef ref, String newStatus) {
  DMethod.printTitle('setRegisterCandidateStatus', newStatus);
  ref.read(registerCandidateStatusProvider.notifier).state = newStatus;
}

final candidateStatusProvider = StateProvider.autoDispose((ref) => '');

setCandidateStatus(WidgetRef ref, String newStatus) {
  DMethod.printTitle('setCandidateStatus', newStatus);
  ref.read(candidateStatusProvider.notifier).state = newStatus;
}

final previousVoteListProvider = StateNotifierProvider.autoDispose<PreviousVoteList, List<CandidateModel>>((ref) => PreviousVoteList([]));

class PreviousVoteList extends StateNotifier<List<CandidateModel>> {
  PreviousVoteList(super.state);

  setData(List<CandidateModel> newData) {
    state = newData;
  }
}

final candidateThisYearListProvider =
    StateNotifierProvider.autoDispose<CandidateThisYearList, List<CandidateModel>>((ref) => CandidateThisYearList([]));

class CandidateThisYearList extends StateNotifier<List<CandidateModel>> {
  CandidateThisYearList(super.state);

  setData(List<CandidateModel> newData) {
    state = newData;
  }
}
