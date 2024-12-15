// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/home_feature/presentation/cubit/home_cubit.dart'
    as _i432;
import '../../features/login_feature/presentation/cubit/login_cubit.dart'
    as _i714;
import '../cubit/language_cubit.dart' as _i731;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i731.LanguageCubit>(() => _i731.LanguageCubit());
    gh.lazySingleton<_i432.HomeCubit>(() => _i432.HomeCubit());
    gh.lazySingleton<_i714.AuthCubit>(() => _i714.AuthCubit());
    return this;
  }
}
