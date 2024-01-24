import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/constants/strings.dart';
import 'package:movies_app/data/model/character_model.dart';
import 'package:movies_app/remote/dio_helper.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit() : super(CharactersInitial());

  static CharactersCubit get(context)=>BlocProvider.of(context);

  CharactersModel? charactersModel;

  void getAllCharacters(){
    emit(CharacterLoadingState());
    DioHelper.getData(
        url: CHARACTER,
    ).then((value) {
          charactersModel = CharactersModel.fromJson(value.data);

      //    print(charactersModel!.results![0].image);
          emit(CharacterSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CharacterErrorState(error.toString()));
    });
  }

}
