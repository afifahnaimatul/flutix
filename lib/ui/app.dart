import 'package:bwa_flutix/bloc/page_bloc.dart';
// import 'package:bwa_flutix/bloc/user_bloc.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:bwa_flutix/ui/custom_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:bwa_flutix/bloc/blocs.dart';
// import 'package:../bloc/blocs.dart';
import 'pages/pages.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(create: (_) => ThemeBloc()),
          BlocProvider(create: (_) => MovieBloc()..add(FetchMovies())),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (_, themeState) => MaterialApp(
            theme: themeState.themeData,
            title: 'Flutix',
            // theme: ThemeData(accentColor: darkPurple, primarySwatch: yellow),
            home: Wrapper(),
          ),
        ),
      ),
    );
  }
}
