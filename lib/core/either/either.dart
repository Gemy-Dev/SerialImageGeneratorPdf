import 'package:flutter/foundation.dart';

abstract class Either<L,R>{

factory Either.left(L value)=Left<L,R>;
factory Either.right(R value)=Right<L,R>;
T fold<T>(T Function(L left) onLeft,T Function(R right) onRight);
}
class Left<L,R> implements Either<L,R>{
final L value;

  Left( this.value);
  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
   return onLeft(value);
  }

}
class Right<L,R> implements Either<L,R>{
  final R value;

  Right(this.value);
  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
  return onRight(value);
  }

}