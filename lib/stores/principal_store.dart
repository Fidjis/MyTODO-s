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

    @computed
    bool get issLoading => isLoading;
    
    @action
    setLogged(bool val) {
      isLogged = val;
    }

    @action
    setIsLoading(bool val) {
      isLoading = val;
    }
}