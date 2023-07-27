class User {
  User(
    this.id, {
    required this.name,
    required this.fam,
    required this.otch,
    required this.role,
    required this.banned,
    required this.deleted,
  });

  int id;
  String name;
  String fam;
  String otch;
  String role;
  bool banned;
  bool deleted;
}

class JournalFoodCert {
  JournalFoodCert({
    required this.date,
    required this.dish,
    required this.timespend,
    required this.rating,
    required this.serveTime,
    required this.user,
    required this.userdone,
    required this.note,
  });

  List<int> date;
  int dish;
  int timespend;
  int rating;
  int serveTime;
  int user;
  int userdone;
  String note;
}

class JournalHealth {
  JournalHealth({
    required this.id,
    required this.date,
    required this.user,
    required this.proffesion,
    required this.okz,
    required this.anginamark,
    required this.diagnos,
    required this.passtowork,
    required this.signSupervisor,
    required this.signWorker,
  });
  int id;
  List<int> date;
  int user;
  int proffesion;
  bool okz;
  bool anginamark;
  String diagnos;
  bool passtowork;
  bool signSupervisor;
  bool signWorker;
}

class JournalTemperature {
  JournalTemperature({
    required this.id,
    required this.user,
    required this.date,
    required this.time,
    required this.temperature,
    required this.vlazhn,
    required this.warehouse,
    required this.appliance,
    required this.sign,
  });
  int id;

  int user;
  List<int> date;
  List<int> time;
  int temperature;
  int vlazhn;
  String warehouse;
  String appliance;
  bool sign;
}

class DishEntry {
  DishEntry({
    required this.id,
    required this.name,
    required this.category,
    required this.active,
  });
  int id;
  String name;
  String category;
  bool active;
}

class ProfessionEntry {
  const ProfessionEntry({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;
}

class Appliance {
  const Appliance({
    required this.id,
    required this.name,
    required this.normalPoint,
    required this.startNormalPoint,
    required this.endNormalPoint,
  });
  final int id;
  final String name;
  final String normalPoint;
  final int startNormalPoint;
  final int endNormalPoint;
}

class ImportControlEntry {
  const ImportControlEntry({
    required this.id,
    required this.supplyOfFoodDate,
    required this.nameOfProduct,
    required this.manufactureOfProduct,
    required this.supplierOfProduct,
    required this.numberOfBatch,
    required this.transportConditions,
    required this.complianceOfRequirements,
    required this.resultOfOrganolepticAssessment,
    required this.expiryDate,
    required this.actualSaleDate,
    required this.note,
  });
  final int id;
  final String supplyOfFoodDate;
  final String nameOfProduct;
  final String manufactureOfProduct;
  final String supplierOfProduct;
  final int numberOfBatch;
  final String transportConditions;
  final bool complianceOfRequirements;
  final String resultOfOrganolepticAssessment;
  final String expiryDate;
  final String actualSaleDate;
  final String note;
}
