import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stayfinder_vendor/logic/blocs/form_bloc/form_bloc.dart';
import 'package:stayfinder_vendor/logic/cubits/on_boarding/on_boarding_cubit.dart';
import 'package:stayfinder_vendor/presentation/config/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  // const MyApp(super.key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true, fontFamily: 'Poppins'),
        onGenerateRoute: appRouter.onGeneratedRoute,
      ),
    );
  }
}
