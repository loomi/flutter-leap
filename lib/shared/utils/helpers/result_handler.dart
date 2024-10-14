/// A utility function to handle the result of an asynchronous operation
/// with success, error, and completion callbacks.
///
/// This function executes the given [action]. Based on the outcome,
/// it calls either the [onSuccess] callback with the result data,
/// or the [onError] callback with the exception and stack trace.
/// Additionally, it calls the [onComplete] callback after the operation completes,
/// whether it was successful or not.
///
/// - Parameters:
///   - action: A function that returns a `Future` of type `T`.
///   - onSuccess: A callback function to handle the success case with the result data of type `T`.
///   - onError: A callback function to handle the error case with an `Exception` and `StackTrace`.
///   - onComplete: An optional callback function to be called upon completion of the operation.
Future<void> handleResultWithCallback<T>({
  required Future<T> Function() action,
  required Function(T data) onSuccess,
  required Function(Exception error, StackTrace s) onError,
  Function()? onComplete,
}) async {
  try {
    T result = await action();
    onSuccess(result);
  } on Exception catch (e, s) {
    onError(e, s);
  } finally {
    onComplete?.call();
  }
}

/// A utility function to handle the result of an asynchronous operation
/// and return a [HandledResult] that encapsulates either the data or the error with stack trace.
///
/// This function executes the given [action]. Based on the outcome,
/// it returns a [HandledResult] containing either the result data or the
/// exception and stack trace.
///
/// - Parameter action: A function that returns a `Future` of type `T`.
/// - Returns: A `Future` that completes with a [HandledResult] containing either the data or the error with stack trace.
Future<HandledResult<T>> handleResult<T>(Future<T> Function() action) async {
  try {
    T result = await action();
    return HandledResult.success(result);
  } on Exception catch (e, s) {
    return HandledResult.failure(e, s);
  }
}

/// A class that represents the result of an operation, encapsulating either
/// the data in case of success, or the error and stack trace in case of failure.
///
/// This class provides a convenient way to handle the outcome of operations
/// by checking the [isSuccess] and [isFailure] properties.
///
/// - Type parameter `T`: The type of the data.
class HandledResult<T> {
  final T? data;
  final Exception? error;
  final StackTrace? stackTrace;

  HandledResult._({this.data, this.error, this.stackTrace});

  /// Factory constructor to create a [HandledResult] representing a success
  /// with the given [data].
  factory HandledResult.success(T data) {
    return HandledResult._(data: data);
  }

  /// Factory constructor to create a [HandledResult] representing a failure
  /// with the given [error] and optional [stackTrace].
  factory HandledResult.failure(Exception error, StackTrace? stackTrace) {
    return HandledResult._(error: error, stackTrace: stackTrace);
  }

  /// Indicates whether the result is a success.
  bool get isSuccess => data != null;

  /// Indicates whether the result is a failure.
  bool get isFailure => error != null;
}
