import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d_method/d_method.dart';

final reportFraudStatus = StateProvider.autoDispose((ref) => '');

setReportFraudStatus(WidgetRef ref, String newStatus) {
  DMethod.printTitle('setReportFraudStatus', newStatus);
  ref.read(reportFraudStatus.notifier).state = newStatus;
}
