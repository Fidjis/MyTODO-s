import 'package:mobx/mobx.dart';

part 'principal_store.g.dart';

class PrincipalSt extends PrincipalStBase with _$PrincipalSt {
  static PrincipalSt _instance;
  factory PrincipalSt() {
    _instance ??= PrincipalSt._internalConstructor();
    return _instance;
  }
  PrincipalSt._internalConstructor();
}

abstract class PrincipalStBase with Store {
  
    @observable
    bool isLogged = false;

    @observable
    bool isLoading = false;

    @observable
    bool isLoadingTaskToDo = true;

    @observable
    bool isLoadingTaskDone = true;
    
    @action
    setLogged(bool val) {
      isLogged = val;
    }

    @action
    setIsLoading(bool val) {
      isLoading = val;
    }

    @action
    setIsLoadingTaskDone(bool val) {
      isLoadingTaskDone = val;
    }

    @action
    setiIsLoadingTaskToDo(bool val) {
      isLoadingTaskToDo = val;
    }
}