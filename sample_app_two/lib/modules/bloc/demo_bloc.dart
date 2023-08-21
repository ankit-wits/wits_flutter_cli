import 'package:flutter_bloc/flutter_bloc.dart';

import 'demo_event.dart';
import 'demo_state.dart';

class SampleBloc extends Bloc<SampleEvent, SampleState> {
  SampleBloc() : super(SampleInitial()) {
    on<SampleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
