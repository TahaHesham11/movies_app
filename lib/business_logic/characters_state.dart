part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharacterLoadingState extends CharactersState{}
class CharacterSuccessState extends CharactersState{



}
class CharacterErrorState extends CharactersState{

  final String error;

  CharacterErrorState(this.error);

}
