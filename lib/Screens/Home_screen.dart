import 'package:api_integration_bloc/Models/News_model.dart';
import 'package:api_integration_bloc/repo/Repository.dart';
import 'package:flutter/material.dart';
import '../Bloc/api_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApiBloc>(
          create: (BuildContext context) => ApiBloc(Repository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('The BloC App')),
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => ApiBloc(
        Repository(),
      )..add(LoadEvent()),
      child: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ApiLoaded) {
            List<Welcome> userList = state.welcome;
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Card(
                        color: Theme.of(context).primaryColor,
                        child: ListTile(
                            title: Text(
                              '${userList[index].firstName}  ${userList[index].lastName}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              '${userList[index].email}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  userList[index].avatar.toString()),
                            ))),
                  );
                });
          }
          if (state is ApiError) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }
}

