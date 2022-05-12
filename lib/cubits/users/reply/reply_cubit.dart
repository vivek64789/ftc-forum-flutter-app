import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reply_state.dart';

class ReplyCubit extends Cubit<ReplyState> {
  ReplyCubit() : super(ReplyInitial());
}
