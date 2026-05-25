sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

final class Failure<T> extends Result<T> {
  final String message;
  final String? refCode;
  const Failure(this.message, {this.refCode});
}

extension ResultX<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T get valueOrThrow => switch (this) {
        Success(:final value) => value,
        Failure(:final message) => throw Exception(message),
      };

  T? get valueOrNull => switch (this) {
        Success(:final value) => value,
        Failure() => null,
      };

  R fold<R>({required R Function(T) onSuccess, required R Function(String) onFailure}) =>
      switch (this) {
        Success(:final value) => onSuccess(value),
        Failure(:final message) => onFailure(message),
      };
}
