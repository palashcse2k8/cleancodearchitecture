import 'package:cleancodearchitecture/bloc/logic/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitCounter extends Cubit<CounterState> {
  CubitCounter() : super(CounterState(initialCounter: 0, incremented: true));

  void increment() =>
      emit(CounterState(initialCounter: state.initialCounter + 1, incremented: true));

  void decrement() =>
      emit(CounterState(initialCounter: state.initialCounter - 1, incremented: false));
}
