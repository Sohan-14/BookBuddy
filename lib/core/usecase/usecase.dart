/// Base contract for all usecases.
/// [T] is the return type, [Params] is the input.
abstract interface class UseCase<T, Params> {
  Future<T> call(Params params);
}

/// Use this for usecases that take no parameters.
class NoParams {
  const NoParams();
}
