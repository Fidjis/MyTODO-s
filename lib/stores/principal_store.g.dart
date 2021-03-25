// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'principal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PrincipalSt on PrincipalStBase, Store {
  final _$isLoggedAtom = Atom(name: 'PrincipalStBase.isLogged');

  @override
  bool get isLogged {
    _$isLoggedAtom.reportRead();
    return super.isLogged;
  }

  @override
  set isLogged(bool value) {
    _$isLoggedAtom.reportWrite(value, super.isLogged, () {
      super.isLogged = value;
    });
  }

  final _$isLoadingAtom = Atom(name: 'PrincipalStBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isLoadingTaskToDoAtom =
      Atom(name: 'PrincipalStBase.isLoadingTaskToDo');

  @override
  bool get isLoadingTaskToDo {
    _$isLoadingTaskToDoAtom.reportRead();
    return super.isLoadingTaskToDo;
  }

  @override
  set isLoadingTaskToDo(bool value) {
    _$isLoadingTaskToDoAtom.reportWrite(value, super.isLoadingTaskToDo, () {
      super.isLoadingTaskToDo = value;
    });
  }

  final _$isLoadingTaskDoneAtom =
      Atom(name: 'PrincipalStBase.isLoadingTaskDone');

  @override
  bool get isLoadingTaskDone {
    _$isLoadingTaskDoneAtom.reportRead();
    return super.isLoadingTaskDone;
  }

  @override
  set isLoadingTaskDone(bool value) {
    _$isLoadingTaskDoneAtom.reportWrite(value, super.isLoadingTaskDone, () {
      super.isLoadingTaskDone = value;
    });
  }

  final _$PrincipalStBaseActionController =
      ActionController(name: 'PrincipalStBase');

  @override
  dynamic setLogged(bool val) {
    final _$actionInfo = _$PrincipalStBaseActionController.startAction(
        name: 'PrincipalStBase.setLogged');
    try {
      return super.setLogged(val);
    } finally {
      _$PrincipalStBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsLoading(bool val) {
    final _$actionInfo = _$PrincipalStBaseActionController.startAction(
        name: 'PrincipalStBase.setIsLoading');
    try {
      return super.setIsLoading(val);
    } finally {
      _$PrincipalStBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsLoadingTaskDone(bool val) {
    final _$actionInfo = _$PrincipalStBaseActionController.startAction(
        name: 'PrincipalStBase.setIsLoadingTaskDone');
    try {
      return super.setIsLoadingTaskDone(val);
    } finally {
      _$PrincipalStBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setiIsLoadingTaskToDo(bool val) {
    final _$actionInfo = _$PrincipalStBaseActionController.startAction(
        name: 'PrincipalStBase.setiIsLoadingTaskToDo');
    try {
      return super.setiIsLoadingTaskToDo(val);
    } finally {
      _$PrincipalStBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogged: ${isLogged},
isLoading: ${isLoading},
isLoadingTaskToDo: ${isLoadingTaskToDo},
isLoadingTaskDone: ${isLoadingTaskDone}
    ''';
  }
}
