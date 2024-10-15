import 'package:bloc/bloc.dart';

class DrawerState {
  final int selectedIndex;

  DrawerState(this.selectedIndex);
}

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerState(0)); // Inicia con la primera opción seleccionada.

  void selectItem(int index) {
    emit(DrawerState(index));
  }
}
