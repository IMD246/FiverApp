bool equalList<T>(
  List<T> list1,
  List<T> list2, {
  bool Function(T item1, T item2)? equal,
}) {
  // if both list are empty
  // then no need no compare
  // return true directly
  if (list1.isEmpty && list2.isEmpty) {
    return true;
  } else if (list1.length == list2.length) {
    // if both list have equal length
    // take first list every element and compare with second list every element
    // if all element are same it will return true
    final bool isSame = list1.every(
      (e1) {
        return list2.any(
          (e2) {
            if (equal != null) {
              return equal(e1, e2);
            }
            return e1 == e2;
          },
        );
      },
    );

    return isSame;
  } else {
    // when both list are not equal length
    return false;
  }
}

extension IsNullOrEmpty<T> on T {
  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    }

    if (this is String) {
      return (this as String).isEmpty;
    }

    if (this is Iterable) {
      return (this as Iterable).isEmpty;
    }

    if (this is List?) {
      return (this as List?) == null || (this as List?)!.isEmpty;
    }

    if (this is List) {
      return (this as List).isEmpty;
    }

    if (this is Map) {
      return (this as Map).isEmpty;
    }

    if (this is bool) {
      return false;
    }

    if (this is num) {
      return false;
    }

    return false;
  }
}
