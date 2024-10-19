import 'package:bloc/bloc.dart';
import 'package:proyecto_final/features/navigation/entities/drawer-state.entity.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerState(0)); // Start with first item selected.

  void selectItem(int index) {
    emit(DrawerState(index));
  }
}
