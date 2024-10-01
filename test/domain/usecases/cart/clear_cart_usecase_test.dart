import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture_e_commerce_app/core/error/failures.dart';
import 'package:flutter_tdd_clean_architecture_e_commerce_app/core/usecases/usecase.dart';
import 'package:flutter_tdd_clean_architecture_e_commerce_app/domain/repositories/cart_repository.dart';
import 'package:flutter_tdd_clean_architecture_e_commerce_app/domain/usecases/cart/clear_cart_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late ClearCartUseCase usecase;
  late MockCartRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockCartRepository();
    usecase = ClearCartUseCase(mockProductRepository);
  });

  test(
    'Should get clea item from the repository when Cart Repository clear data successfully',
    () async {
      /// Arrange
      when(() => mockProductRepository.clearCart())
          .thenAnswer((_) async => const Right(true));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, const Right(true));
      verify(() => mockProductRepository.clearCart());
      verifyNoMoreInteractions(mockProductRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockProductRepository.clearCart())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockProductRepository.clearCart());
    verifyNoMoreInteractions(mockProductRepository);
  });
}
