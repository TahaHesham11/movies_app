import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:movies_app/business_logic/characters_cubit.dart';
import 'package:movies_app/components.dart';
import 'package:movies_app/constants/my_colors.dart';
import 'package:movies_app/data/model/character_model.dart';
import 'package:movies_app/modules/screens/characters_details_screen.dart';

class CharacterScreen extends StatefulWidget {
  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
   List<Results>? searchForCharacter;
  bool isSearching = false;
  CharactersModel? charactersModel;

  var searchController = TextEditingController();
   @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharactersCubit, CharactersState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: MyColor.myYellow,
                title: isSearching ? buildSearchField() : buildAppBarTitle(),
                actions:buildAppBarActions(),

              ),
              body: OfflineBuilder(
                connectivityBuilder: (
                    BuildContext context,
                    ConnectivityResult connectivity,
                    Widget child,)
                {
                  final bool connected = connectivity != ConnectivityResult.none;
                  if(connected){
                   return  ConditionalBuilder(
                       condition: state is! CharacterLoadingState,
                       builder: (context) => buildGridItem(CharactersCubit.get(context).charactersModel!),
                       fallback: (context) => Center(
                           child: CircularProgressIndicator(
                         color: MyColor.myYellow,
                       )
                       ),

                     );
                  }else{
                    return buildNoInternetWidget();
                  }
          },
                child: Center(
                  child: CircularProgressIndicator(color: MyColor.myYellow,),
                ),
              )


          );
        });
  }
Widget buildNoInternetWidget(){

     return Center(
       child: Container(
         color: Colors.white,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(height: 20,),
             DefaultTextStyle(
               style: const TextStyle(
                 fontSize: 20,
                 color: MyColor.myGrey,
                 shadows: [
                   Shadow(
                     blurRadius: 7.0,
                     color: Colors.white,
                     offset: Offset(0, 0),
                   ),
                 ],
               ), child: AnimatedTextKit(
               repeatForever: true,
               animatedTexts: [
                 FlickerAnimatedText('Can\'t connect check internet'),

               ],
             ),


             ),
             Image(image: AssetImage(
               'assets/images/no_internet.png'
             ),
             )
           ],
         ),
       ),
     );
}
  Widget buildGridItem(CharactersModel model) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: MyColor.myGrey,
        child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.53,
            children: List.generate(
               searchController.text.isEmpty ? model.results!.length : searchForCharacter!.length,
                (index) => buildProductsItem(searchController.text.isEmpty ? model.results![index] : searchForCharacter![index],
                )
            ),
        ),
      ),
    );
  }

  Widget buildProductsItem(Results results,) {
    return InkWell(
      onTap: (){
        navigateTo(context, CharactersDetailsScreen(
          id: results.id!,
          name: results.name!,
          image: results.image!,
          status: results.status!,
          species: results.species!,
          gender: results.gender!,
          created: results.created!,
        ));
      },
      child: Column(
          children: [
        Hero(
          tag: '2',
          child: Container(
            width: double.infinity,
            margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            padding: EdgeInsetsDirectional.all(4),
            decoration: BoxDecoration(
              color: MyColor.myWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0),
                              Colors.black.withOpacity(1),
                            ],
                            stops: [
                              0.6,
                              1
                            ]),
                      ),
                      child: results.image!.isNotEmpty
                          ? FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.gif',
                              image: results.image!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset('assets/images/male1.png'),
                      width: 200,
                      height: 250,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      width: 200,
                      child: Text(
                        results.name!,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      cursorColor: MyColor.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a characters',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColor.myGrey, fontSize: 18),
      ),
      style: TextStyle(color: MyColor.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter,) {
    searchForCharacter =CharactersCubit.get(context).charactersModel!.results!.where((element) =>
            element.name!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
            onPressed: () {
              clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: MyColor.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: startSearch,
            icon: Icon(
              Icons.search,
              color: MyColor.myGrey,
            ))
      ];
    }
  }

  void startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching= true;
    });
  }

  void stopSearching(){
    clearSearch();
    setState(() {
      isSearching=false;
    });
  }

  void clearSearch(){
    searchController.clear();
  }

  Widget buildAppBarTitle(){
    return Text(
      'Characters',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
