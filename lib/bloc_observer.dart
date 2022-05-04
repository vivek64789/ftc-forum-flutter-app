import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object? event) {
    print("${bloc.runtimeType} $event");
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print("${bloc.runtimeType} $error");
    super.onError(bloc, error, stackTrace);
  }

  @override 
  void onChange(BlocBase bloc, Change change) {
    print("${bloc.runtimeType} $change");
    super.onChange(bloc, change);
  }

  @override 
  void onTransition(Bloc bloc, Transition transition) {
    print("${bloc.runtimeType} $transition");
    super.onTransition(bloc, transition);
  }
}


// class AppBlocObserver extends BlocObserver {
//   @override
//   void onEvent(Bloc bloc, Object? event) {
//     super.onEvent(bloc, event);
//     print('${bloc.runtimeType} $event');
//   }

//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     print('${bloc.runtimeType} $error');
//     super.onError(bloc, error, stackTrace);
//   }

//   @override
//   void onChange(BlocBase bloc, Change change) {
//     print('${bloc.runtimeType} $change');
//     super.onChange(bloc, change);
//   }

//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     print('${bloc.runtimeType} $transition');
//     super.onTransition(bloc, transition);
//   }
// }
