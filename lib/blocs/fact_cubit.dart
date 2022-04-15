import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamelott_facts/repository/kaamelott_repository.dart';

import '../models/fact.dart';

class FactCubit extends Cubit<List<Fact>>
{
  FactCubit(this._repository) : super([]);
  final KaamelottRepository _repository;

  Future<void> loadFacts() async {
    final List<Fact> facts = await _repository.fetchFact();
    emit(facts);
  }
}