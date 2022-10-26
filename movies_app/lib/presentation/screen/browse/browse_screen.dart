import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/cubit/app_cubit/app_cubit.dart';
import '../../../business_logic/cubit/app_cubit/app_states.dart';
import '../../../components/constants/constants.dart';
import '../../../data/netowrk/movie_api_helper.dart';
import '../../layout/categoryItem.dart';

class BrowseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
        if (state is GetDataBrowseSuccessState) print('done');
      }, builder: (context, state) {
        if (AppCubit.get(context).Catogerys.isEmpty) {
          AppCubit.get(context).GetDataBrowse();

        }
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child:AppCubit.get(context).Catogerys.isEmpty
              ? const Center(
            child:  CircularProgressIndicator(
              color: Colors.amber,
            ),
          ) : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              const Text(
                'Browse Category',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: AppCubit.get(context).Catogerys.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return CategoryItem(index: index,);
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
