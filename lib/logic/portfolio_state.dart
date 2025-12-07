part of 'portfolio_bloc.dart';

class PortfolioState extends Equatable {
  final int selectedIndex;

  const PortfolioState(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
