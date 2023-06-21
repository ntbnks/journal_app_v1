import 'package:journal_app_v1/model/models.dart';

String genUserNameSelected(List<User> userList, int index) {
  final User user = userList.firstWhere((e) => e.id == index);
  return '${user.fam} ${user.name}';
}

String genUserFirstnameSecondnameLastname(User user) {
  return '${user.fam} ${user.name} ${user.otch}';
}
