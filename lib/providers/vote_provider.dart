import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d_method/d_method.dart';

final voteStatusProvider = StateProvider.autoDispose((ref) => '');

setVoteStatus(WidgetRef ref, String newStatus) {
  DMethod.printTitle('setVoteStatus', newStatus);
  ref.read(voteStatusProvider.notifier).state = newStatus;
}
