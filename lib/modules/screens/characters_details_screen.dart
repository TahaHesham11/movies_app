import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/business_logic/characters_cubit.dart';
import 'package:movies_app/constants/my_colors.dart';

class CharactersDetailsScreen extends StatelessWidget {

final int id;
final String name;
final String image;
final String status;
final String species;
final String gender;
final String created;

  const CharactersDetailsScreen({
  required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.species,
    required this.gender,
    required this.created,

});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => CharactersCubit(),
  child: BlocConsumer<CharactersCubit, CharactersState>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
     backgroundColor: MyColor.myGrey,

      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      charactersInfo(title: 'status : ',value: status),
                      buildDivider(260.0,),
                      charactersInfo(title: 'species : ',value: species),
                      buildDivider(260.0,),
                      charactersInfo(title: 'gender : ',value: gender),
                      buildDivider(260.0,),
                      charactersInfo(title: 'created : ',value: created),
                      buildDivider(260.0,),
                      SizedBox(height: 20,),

                SizedBox(height: 500)

              ]
          ),
          )
        ],
      ),
          )
        ]
          )
    );


  },
),
);
  }

  Widget buildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColor.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
        name,
          style: TextStyle(
            color: Colors.white,
          ),
        //  textAlign: TextAlign.start,
        ),
      background: Hero(
        tag: '1',
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
      ),
    );
  }

  Widget charactersInfo({
  required String title,
   required String value,
}) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text : title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: MyColor.myWhite
              )
            ),
            TextSpan(
              text : value,
                style: TextStyle(
                    fontSize: 16,
                    color: MyColor.myWhite
              )
            ),
          ]
        ),
    );

  }


  Widget buildDivider(double endIndent){

    return Divider(
      color: MyColor.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }
}
