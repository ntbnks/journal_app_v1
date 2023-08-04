import 'package:flutter/cupertino.dart';
import 'package:journal_app_v1/method/date_time_handler.dart';
import 'package:journal_app_v1/model/models.dart';
import 'package:journal_app_v1/model/restapi.dart';
import 'package:journal_app_v1/page/login_page.dart';
import 'package:journal_app_v1/ui/values.dart';

enum RequestType { users, certification, health, temperature }

const addresses = ['usersget', 'brackget'];

class MainProvider extends ChangeNotifier {
  /// gives you debug info
  bool debug = false;

  /// Loading
  bool loading = false;

  /// Lists of stuff
  List<User> userList = [];
  List<JournalFoodCert> certList = [];
  List<JournalHealth> healthList = [];
  List<JournalTemperature> tmprList = [];
  List<DishEntry> dishList = [];
  List<ProfessionEntry> professionList = [];
  List<Appliance> applianceList = [];

  List<ImportControlEntry> importControlList = [];
  List<PerishableFoodEntry> perishableFoodList = [];
  List<MedExamEntry> medExamList = [];

  /// CURRENT USER INFO
  int currentUser = -1;
  String currentUserName = '';
  void genCurrentUserName() {
    final e = userList.firstWhere((element) => element.id == currentUser);

    currentUserName = '${e.fam} ${e.name} ${e.otch}';
  }

  /// Initiate loading
  void startLoading() {
    loading = true;
    notifyListeners();
  }

  /// Global error messages
  String errorMessage = '';
  String statusMsg = '';

  void errorCall(String msg) {
    errorMessage = msg;
    notifyListeners();
  }

  void newStatus(String msg) {
    statusMsg = msg;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  /// GENERIC FETCH REQUEST HERE
  void delegateFetchTask(String destination, Function(dynamic value) onSuccess,
      {bool noRefresh = false}) {
    if (!noRefresh) {
      setLoading(true);
    }
    errorMessage = '';
    String responseValue = '';
    RestAPI()
        .fetch(destination)
        // Success case
        .then((value) {
      responseValue = value.toString();
      onSuccess(value);
    })
        // Failure case
        .catchError((error) {
      errorMessage = error.toString();
      responseValue = error.toString();
    })
        // When finished
        .whenComplete(() {
      print(responseValue);
      setLoading(false);
    });
  }

  /// REQUESTS START HERE
  void requestUserList() {
    delegateFetchTask('usersGet', (value) {
      userList.clear();
      for (final e in value) {
        userList.add(
          User(
            (e as Map)['id'] as int,
            name: e['name'] as String,
            fam: e['fam'] as String,
            otch: e['otch'] as String,
            role: e['role'] as String,
            banned: e['banned'] as bool,
            // deleted: e['deleted'] as bool,
          ),
        );
      }
    });
  }

  Future<List<JournalFoodCert>?> requestCertList() {
    loading = true;
    notifyListeners();
    return RestAPI().fetch('brackGet').then((value) {
      certList.clear();
      for (final e in value) {
        certList.add(
          JournalFoodCert(
            date: dateTimeParser((e as Map)['date'] as String),
            dish: e['dish'] as int,
            timespend: e['timespend'] as int,
            rating: e['rating'] as int,
            serveTime: e['serveTime'] as int,
            user: e['user'] as int,
            userdone: e['userdone'] as int,
            note: e['note'] as String,
          ),
        );
      }
      return certList;
    }).catchError((error) {
      errorMessage = error.toString();
    }).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }

  void requestHealthList() {
    delegateFetchTask('healthget', (value) {
      healthList.clear();
      for (final e in value) {
        healthList.add(
          JournalHealth(
            id: (e as Map)['id'] as int,
            date: dateTimeParser(e['date'] as String),
            user: e['Users'] as int,
            proffesion: e['ConnectionUserProfessions'] as int,
            okz: e['okz'] as bool,
            anginamark: e['anginamark'] as bool,
            diagnos: e['diagnos'] as String,
            passtowork: e['passtowork'] as bool,
            signSupervisor: e['signSupervisor'] as bool,
            signWorker: e['signWorker'] as bool,
          ),
        );
      }
    });
  }

  void requestTmprList() {
    delegateFetchTask('tempControlGet', (value) {
      tmprList.clear();
      for (final e in value) {
        Appliance? appliance;
        if (e['appliance'] != null) {
          final x = e['appliance'] as Map<String, dynamic>;

          appliance = Appliance(
            id: x['id'] as int,
            name: x['name'] as String,
            normalPoint: x['normalPoint'] as String,
            startNormalPoint: x['startNormalPoint'] as int,
            endNormalPoint: x['endNormalPoint'] as int,
          );
        }

        tmprList.add(
          JournalTemperature(
            id: (e as Map)['id'] as int,
            date: dateTimeParser(e['date'] as String),
            // time: dateTimeParser(e['time'] as String, splitSymbol: ':'),
            time: [int.tryParse(e['time'] as String) ?? 0, 0, 0],
            user: e['user'] as int,
            temperature: e['temperature'] as int,
            vlazhn: e['vlazhn'] as int,
            warehouse: '0',
            // warehouse: e['warehouse'] as String,
            appliance: appliance,
            sign: e['sign'] as bool,
          ),
        );
      }
    });
  }

  void requestDishList() {
    delegateFetchTask('dishesGet', (value) {
      dishList.clear();
      for (final e in value) {
        dishList.add(
          DishEntry(
            id: (e as Map)['id'] as int,
            name: e['dish'] as String,
            // category: e['category'] as String,
            category: 'Гарниры',
            // active: e['active'] as bool,  // Users will fill this field
            active: false,
          ),
        );
      }
    });
  }

  void requestImportControlData() {
    delegateFetchTask('enterControlOfFoodGet', (value) {
      importControlList.clear();
      for (final e in value) {
        importControlList.add(
          ImportControlEntry(
            id: e['id'] as int,
            supplyOfFoodDate: e['supplyOfFoodDate'] as String,
            nameOfProduct: e['nameOfProduct'] as String,
            manufactureOfProduct: e['manufactureOfProduct'] as String,
            supplierOfProduct: e['supplierOfProduct'] as String,
            numberOfBatch: e['numberOfBatch'] as int,
            transportConditions: e['transportConditions'] as String,
            complianceOfRequirements: e['complianceOfRequirements'] as bool,
            resultOfOrganolepticAssessment: e['resultOfOrganolepticAssessment'] as String,
            expiryDate: e['expiryDate'] as String,
            actualSaleDate: e['actualSaleDate'] as String,
            note: e['note'] as String,
          ),
        );
      }
    });
  }

  void requestPerishableFoodData() {
    delegateFetchTask('perishableFoodGet', (value) {
      perishableFoodList.clear();
      for (final e in value) {
        perishableFoodList.add(
          PerishableFoodEntry(
            id: e['id'] as int,
            name: e['name'] as String,
            openingDate: e['openingDate'] as String,
            manufactureDateTime: e['manufactureDateTime'] as String,
            expiryDate: e['expiryDate'] as String,
            periodOfSaleDate: e['periodOfSaleDate'] as String,
            userLink: (e['user'] as Map)['id'] as int,
          ),
        );
      }
    });
  }

  void requestMedExamData() {
    delegateFetchTask('medicalExaminationGet', (value) {
      perishableFoodList.clear();
      for (final e in value) {
        medExamList.add(
          MedExamEntry(
            id: e['id'] as int,
            referralDate: e['referralDate'] as String,
            userId: (e['user'] as Map)['id'] as int,
            doneById: (e['user_done'] as Map)['id'] as int,
          ),
        );
      }
    });
  }

  void postBrack({
    required int name,
    required int time,
    required int rating,
    required int serveTime,
    required String note,
    required int userID,
    required int supervisorID,
  }) {
    initiatePostEntry();
    RestAPI()
        .addBrack(
          name: name,
          time: time,
          rating: rating,
          serveTime: serveTime,
          note: note,
          userID: userID,
          supervisorID: supervisorID,
        )
        .then(
          (value) => postErrorHandler(
            value,
            onSuccess: [toggleEdit, requestCertList],
          ),
        )
        .catchError((error) => catchErrorHandler(error));
  }

  void postHealth({
    required int user,
    required int prof,
    required String diagnosis,
  }) {
    initiatePostEntry();

    RestAPI()
        .addHealth(
          username: user,
          prof: prof,
          okz: formHealth.okz,
          anginamark: formHealth.anginamark,
          diagnos: diagnosis,
          passtowork: formHealth.passtowork,
        )
        .then(
          (value) => postErrorHandler(
            value,
            onSuccess: [toggleEdit, requestHealthList],
          ),
        )
        .catchError((error) => catchErrorHandler(error));
  }

  bool validateBeforePost(bool condition) {
    if (condition) {
      problemsList('Одно из полей не заполнено!');
      return false;
    }
    return true;
  }

  void initiatePostEntry() {
    errorMessage = '';
    problems = 'Добавление записи...';
    setLoading(true);
  }

  /// Post in temperature control
  void postTmpr() {
    if (validateBeforePost(
      formTmpr.appliance == null ||
          formTmpr.vlazhn < 0 ||
          formTmpr.temperature < 0 ||
          !formTmpr.sign,
    )) {
      initiatePostEntry();
      RestAPI()
          .addTemperatureControl(
            warehouse: formTmpr.warehouse,
            temperature: formTmpr.temperature,
            vlazhn: formTmpr.vlazhn,
            signature: formTmpr.sign,
            applianceId: formTmpr.appliance!.id,
          )
          .then(
            (value) => postErrorHandler(
              value,
              onSuccess: [toggleEdit, requestTmprList],
            ),
          )
          .catchError((error) => catchErrorHandler(error));
    }
  }

  /// Handlers
  void postErrorHandler(dynamic value, {required List<VoidCallback> onSuccess}) {
    print(value);
    if (value.toString().contains('ERROR!')) {
      errorMessage = value.toString();
      loading = false;
      notifyListeners();
    } else {
      for (final callback in onSuccess) {
        callback();
      }
    }
  }

  void catchErrorHandler(dynamic error) {
    print(error);
    errorMessage = error.toString();
    notifyListeners();
  }

  void clearList(List<dynamic> l) {
    l.clear();
    notifyListeners();
  }

  void logout(BuildContext context) {
    currentUser = -1;
    currentUserName = '';
    loading = false;
    Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
  }
//   void request(
//     String address, {
//     required List<Object> list,
//     required RequestType entryType,
//   }) {
//     loading = true;
//     notifyListeners();
//     RestAPI().fetch(address).then((value) {

// switch (entryType) {
//   case RequestType.users:

//     break;
//   default:
// }

//       for (final e in value) {
//         list.add(

//         );
//       }
//       loading = false;
//       notifyListeners();
//     });
//   }

  /// UI STUFF

  /// Drawer stuff

  bool drawerOpen = true;
  bool drawerMainListOpen = true;
  bool drawerFormsListOpen = true;

  double get currentDrawerSize => drawerOpen ? Val.drawerWidthOpen : Val.drawerWidthClosed;

  void toogleDrawer() {
    switch (drawerOpen) {
      case false:
        drawerOpen = true;
        break;
      default:
        drawerOpen = false;
    }
    notifyListeners();
  }

  void toogleDrawerLists({bool? mainListOpen, bool? formsListOpen}) {
    drawerMainListOpen = mainListOpen ?? drawerMainListOpen;
    drawerFormsListOpen = formsListOpen ?? drawerFormsListOpen;

    notifyListeners();
  }

  void getSizes(double screen, int count) {
    cfSizeOpen = (screen / count) - (Val.drawerWidthOpen / count);
    cfSizeClosed = (screen / count) - (Val.drawerWidthClosed / count);
    t = screen - currentDrawerSize;
  }

  double t = 0;
  double cfSizeOpen = 0;
  double cfSizeClosed = 0;

  double get fSize => drawerOpen ? cfSizeOpen : cfSizeClosed;

  bool pageVisit = false;
  bool editMode = false;

  void pageVisitApprove() {
    pageVisit = true;
    notifyListeners();
  }

  void toggleEdit({bool? value}) {
    editMode = value ?? !editMode;
    problems = '';
    notifyListeners();
  }

  String problems = '';

  void problemsList(String value) {
    problems = value;
    notifyListeners();
  }

  /// FORMS
  ///
  ///
  JournalFoodCert formCert = JournalFoodCert(
    date: [1, 1, 1970],
    dish: -1,
    timespend: 1,
    rating: 3,
    serveTime: 1,
    user: 1,
    userdone: 1,
    note: '',
  );

  void editFormCert({
    List<int>? date,
    int? dish,
    int? timespend,
    int? rating,
    int? serveTime,
    int? user,
    int? userdone,
    String? note,
  }) {
    formCert.date = date ?? formCert.date;
    formCert.dish = dish ?? formCert.dish;
    formCert.timespend = timespend ?? formCert.timespend;
    formCert.rating = rating ?? formCert.rating;
    formCert.serveTime = serveTime ?? formCert.serveTime;
    formCert.user = user ?? formCert.user;
    formCert.userdone = userdone ?? formCert.userdone;
    formCert.note = note ?? formCert.note;
    for (final e in userList) {
      print(e.id);
    }
    print('form cert id:${formCert.user}');
    notifyListeners();
  }

  JournalHealth formHealth = JournalHealth(
    id: -1,
    date: [1, 1, 1970],
    user: 1,
    proffesion: -1,
    okz: false,
    anginamark: false,
    diagnos: '',
    passtowork: true,
    signSupervisor: false,
    signWorker: false,
  );

  void editHealthJournal({
    int? user,
    int? proffesion,
    bool? okz,
    bool? anginamark,
    String? diagnos,
    bool? passtowork,
    bool? signSupervisor,
    bool? signWorker,
  }) {
    formHealth.user = user ?? formHealth.user;
    formHealth.proffesion = proffesion ?? formHealth.proffesion;
    formHealth.okz = okz ?? formHealth.okz;
    formHealth.anginamark = anginamark ?? formHealth.anginamark;
    formHealth.diagnos = diagnos ?? formHealth.diagnos;
    formHealth.passtowork = passtowork ?? formHealth.passtowork;
    formHealth.signSupervisor = signSupervisor ?? formHealth.signSupervisor;
    formHealth.signWorker = signWorker ?? formHealth.signWorker;

    notifyListeners();
  }

  JournalTemperature formTmpr = JournalTemperature(
    id: -1,
    user: 1,
    date: [1, 1, 1970],
    time: [0, 0, 0],
    temperature: -1,
    vlazhn: -1,
    warehouse: '',
    appliance: null,
    sign: false,
  );

  void editTemperatureJournal({
    int? user,
    List<int>? date,
    List<int>? time,
    int? temperature,
    int? vlazhn,
    String? warehouse,
    Appliance? appliance,
    bool? signWorker,
  }) {
    formTmpr.user = user ?? formTmpr.user;
    formTmpr.date = date ?? formTmpr.date;
    formTmpr.time = time ?? formTmpr.time;
    formTmpr.temperature = temperature ?? formTmpr.temperature;
    formTmpr.vlazhn = vlazhn ?? formTmpr.vlazhn;
    formTmpr.warehouse = warehouse ?? formTmpr.warehouse;
    formTmpr.appliance = appliance;
    formTmpr.sign = signWorker ?? formTmpr.sign;

    notifyListeners();
  }

  void editDishActive(DishEntry entry, bool value) {
    entry.active = value;
    notifyListeners();
  }

  void editDishActiveChangeAll(bool value) {
    for (final e in dishList) {
      e.active = value;
    }
    notifyListeners();
  }

  void editDishActiveUpdateCategory(List<DishEntry> list, String category) {
    final List<DishEntry> updatedList =
        dishList.where((element) => element.category == category).toList();
    for (int i = 0; i < updatedList.length; i++) {
      updatedList[i].active = list[i].active;
    }
    formCert.dish = -1; // Removes dish from saved form to avoid adding inaccessible entry

    // RestAPI().postTodaysMenu(id: )
    notifyListeners();
  }

  DishEntry formCreateDish = DishEntry(
    id: -1,
    active: false,
    name: '',
    category: '',
  );

  void editDishCreateEntry({
    String? name,
    String? category,
    bool? active,
  }) {
    formCreateDish.name = name ?? formCreateDish.name;
    formCreateDish.category = category ?? formCreateDish.category;
    formCreateDish.active = active ?? formCreateDish.active;

    notifyListeners();
  }
}
