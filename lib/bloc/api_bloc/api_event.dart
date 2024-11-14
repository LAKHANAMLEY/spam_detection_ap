import 'package:equatable/equatable.dart';

abstract class ApiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetContactEvent extends ApiEvent {}
