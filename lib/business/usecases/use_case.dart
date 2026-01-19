import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:template/app/app.dart';
import 'package:template/core/classes/app_exception.dart';
import 'package:template/core/utils/either.dart';

import '../models/exceptions/api_exception.dart';

abstract class UseCase<Input, Output> extends _UseCase {
  const UseCase();

  @protected
  Future<Output> execute(Input input);

  Future<Either<Exception, Output>> call(Input input) {
    return _call(input: input, execute: execute);
  }
}

abstract class NoInputUseCase<Output> extends _UseCase {
  const NoInputUseCase();

  @protected
  Future<Output> execute();

  Future<Either<Exception, Output>> call() {
    return _call(input: null, execute: (_) => execute());
  }
}

abstract class VoidUseCase<Input> extends _UseCase {
  const VoidUseCase();

  @protected
  Future<void> execute(Input input);

  Future<Either<Exception, void>> call(Input input) {
    return _call(input: input, execute: execute);
  }
}

abstract class VoidNoInputUseCase extends _UseCase {
  const VoidNoInputUseCase();

  @protected
  Future<void> execute();

  Future<Either<Exception, void>> call() {
    return _call(input: null, execute: (_) => execute());
  }
}

abstract class _UseCase {
  const _UseCase();

  @protected
  String? get defaultErrorMessage;

  @protected
  Object? onDioError(DioException error) => null;

  @protected
  Object? onOtherError(Object error, StackTrace stackTrace) => null;

  Future<Either<Exception, Output>> _call<Input, Output>({
    required Input input,
    required Future<Output> Function(Input input) execute,
  }) async {
    try {
      final output = await execute(input);
      return Right(output);
    } catch (error, stackTrace) {
      if (error is AppException) return Left(error);

      if (error is DioException) {
        final onDioErrorResult = onDioError(error);
        if (onDioErrorResult is Exception) {
          return Left(onDioErrorResult);
        } else if (onDioErrorResult is Output) {
          return Right(onDioErrorResult);
        }
      }

      final onOtherErrorResult = onOtherError(error, stackTrace);
      if (onOtherErrorResult is Exception) {
        return Left(onOtherErrorResult);
      } else if (onOtherErrorResult is Output && onOtherErrorResult != null) {
        return Right(onOtherErrorResult);
      }

      final apiException = ApiException.fromError(error);

      if (apiException != null) return Left(apiException);

      App.logError(
        title: runtimeType.toString(),
        error: error,
        stackTrace: stackTrace,
      );
      return Left(AppException(defaultErrorMessage ?? error.toString()));
    }
  }
}
