import '../exceptions/vector_exception.dart';
import '../matrix/matrix.dart';
import '../matrix/square_matrix.dart';
import 'base/vector_base.dart';

/// Class for work with vectors
class Vector extends VectorBase {
  /// Inits [data] for vector
  Vector(List<num> data) : super.init(data);

  @override
  Matrix toMatrixColumn() {
    final matrix = data.map((value) => <num>[value]).toList();
    return Matrix(matrix);
  }

  @override
  Matrix toMatrixRow() => Matrix(<List<num>>[data]);

  @override
  Vector crossProduct(Vector vector) {
    if (itemCount == 3 && vector.itemCount == 3) {
      final v = <num>[];
      for (var i = 1; i <= 3; i++) {
        final m = SquareMatrix(<List<num>>[
          <num>[1, 1, 1],
          data,
          vector.data
        ]);
        m
          ..removeRow(1)
          ..removeColumn(i);
        v.add(m.determinant());
      }
      return Vector(v);
    } else {
      throw VectorException(
          'Vectors should be in three-dimensional Euclidean space.'
          'Found $itemCount and ${vector.itemCount}');
    }
  }

  @override
  Vector hadamardProduct(Vector vector) {
    final data = <num>[];
    for (var i = 1; i <= itemCount; i++) {
      data.add(itemAt(i) * vector.itemAt(i));
    }
    return Vector(data);
  }

  @override
  Vector transform(num t(num value)) => Vector(data.map(t).toList());

  @override
  Vector operator +(Vector vector) {
    if (itemCount == vector.itemCount) {
      final tmpData = <num>[];
      for (var i = 1; i <= itemCount; i++) {
        tmpData.add(itemAt(i) + vector.itemAt(i));
      }
      return Vector(tmpData);
    } else {
      throw VectorException('Count of vector\'s numbers isn\'t equal!');
    }
  }
}