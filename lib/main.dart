import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc_observer.dart';
import 'package:movies_app/modules/screens/characters_screen.dart';
import 'package:movies_app/remote/dio_helper.dart';
import 'business_logic/characters_cubit.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();


  DioHelper.init();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: BlocProvider(
        create: (context) => CharactersCubit()..getAllCharacters(),
        child: CharacterScreen(),
      ),
    );
  }
}


