import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'portfolio_state.dart';

class PortfolioBloc extends Cubit<PortfolioState> {
  PortfolioBloc() : super(const PortfolioState(0));

  void scrollToSection(int index) {
    emit(PortfolioState(index));
  }
}
