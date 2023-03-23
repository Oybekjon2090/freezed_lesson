import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:freezed_lesson/person_model.dart';
import 'package:http/http.dart' as http;

part 'main_event.dart';

part 'main_state.dart';

part 'main_bloc.freezed.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<MainEvent>((event, emit) {
      event.map(
        remove: (s) {
          _remove();
        },
        addCount: (s) {
          _addCount();
        },
        getInfo: (s) {
          _getInfo();
        },
      );
    });
  }

  _getInfo() async {
    var url = Uri.parse("https://api.genderize.io/?name=Aziz");
    var response = await http.get(url);

    emit(state.copyWith(
        person: Person(
            firstName: jsonDecode(response.body)["name"],
            lastName: jsonDecode(response.body)["name"],
            age: jsonDecode(response.body)["count"])));
  }

  _addCount() {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(count: state.count + 1));
  }

  _remove() {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(count: state.count - 1));
  }
}
