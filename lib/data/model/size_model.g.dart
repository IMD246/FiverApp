// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSizeModelCollection on Isar {
  IsarCollection<SizeModel> get sizeModels => this.collection();
}

const SizeModelSchema = CollectionSchema(
  name: r'sizes',
  id: 7887996259756897908,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.long,
    ),
    r'sizeName': PropertySchema(
      id: 1,
      name: r'sizeName',
      type: IsarType.string,
    )
  },
  estimateSize: _sizeModelEstimateSize,
  serialize: _sizeModelSerialize,
  deserialize: _sizeModelDeserialize,
  deserializeProp: _sizeModelDeserializeProp,
  idName: r'idLocal',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _sizeModelGetId,
  getLinks: _sizeModelGetLinks,
  attach: _sizeModelAttach,
  version: '3.1.0+1',
);

int _sizeModelEstimateSize(
  SizeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.sizeName.length * 3;
  return bytesCount;
}

void _sizeModelSerialize(
  SizeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.id);
  writer.writeString(offsets[1], object.sizeName);
}

SizeModel _sizeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SizeModel(
    id: reader.readLong(offsets[0]),
    sizeName: reader.readString(offsets[1]),
  );
  object.idLocal = id;
  return object;
}

P _sizeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sizeModelGetId(SizeModel object) {
  return object.idLocal ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _sizeModelGetLinks(SizeModel object) {
  return [];
}

void _sizeModelAttach(IsarCollection<dynamic> col, Id id, SizeModel object) {
  object.idLocal = id;
}

extension SizeModelQueryWhereSort
    on QueryBuilder<SizeModel, SizeModel, QWhere> {
  QueryBuilder<SizeModel, SizeModel, QAfterWhere> anyIdLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SizeModelQueryWhere
    on QueryBuilder<SizeModel, SizeModel, QWhereClause> {
  QueryBuilder<SizeModel, SizeModel, QAfterWhereClause> idLocalEqualTo(
      Id idLocal) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: idLocal,
        upper: idLocal,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterWhereClause> idLocalNotEqualTo(
      Id idLocal) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: idLocal, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idLocal, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idLocal, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: idLocal, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterWhereClause> idLocalGreaterThan(
      Id idLocal,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idLocal, includeLower: include),
      );
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterWhereClause> idLocalLessThan(
      Id idLocal,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idLocal, includeUpper: include),
      );
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterWhereClause> idLocalBetween(
    Id lowerIdLocal,
    Id upperIdLocal, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIdLocal,
        includeLower: includeLower,
        upper: upperIdLocal,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SizeModelQueryFilter
    on QueryBuilder<SizeModel, SizeModel, QFilterCondition> {
  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> idEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> idLocalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idLocal',
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> idLocalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idLocal',
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> idLocalEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idLocal',
        value: value,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> idLocalGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idLocal',
        value: value,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> idLocalLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idLocal',
        value: value,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> idLocalBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idLocal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> sizeNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sizeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> sizeNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sizeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> sizeNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sizeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> sizeNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sizeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> sizeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sizeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> sizeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sizeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> sizeNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sizeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> sizeNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sizeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition> sizeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sizeName',
        value: '',
      ));
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterFilterCondition>
      sizeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sizeName',
        value: '',
      ));
    });
  }
}

extension SizeModelQueryObject
    on QueryBuilder<SizeModel, SizeModel, QFilterCondition> {}

extension SizeModelQueryLinks
    on QueryBuilder<SizeModel, SizeModel, QFilterCondition> {}

extension SizeModelQuerySortBy on QueryBuilder<SizeModel, SizeModel, QSortBy> {
  QueryBuilder<SizeModel, SizeModel, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterSortBy> sortBySizeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeName', Sort.asc);
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterSortBy> sortBySizeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeName', Sort.desc);
    });
  }
}

extension SizeModelQuerySortThenBy
    on QueryBuilder<SizeModel, SizeModel, QSortThenBy> {
  QueryBuilder<SizeModel, SizeModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterSortBy> thenByIdLocal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idLocal', Sort.asc);
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterSortBy> thenByIdLocalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idLocal', Sort.desc);
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterSortBy> thenBySizeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeName', Sort.asc);
    });
  }

  QueryBuilder<SizeModel, SizeModel, QAfterSortBy> thenBySizeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeName', Sort.desc);
    });
  }
}

extension SizeModelQueryWhereDistinct
    on QueryBuilder<SizeModel, SizeModel, QDistinct> {
  QueryBuilder<SizeModel, SizeModel, QDistinct> distinctById() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id');
    });
  }

  QueryBuilder<SizeModel, SizeModel, QDistinct> distinctBySizeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sizeName', caseSensitive: caseSensitive);
    });
  }
}

extension SizeModelQueryProperty
    on QueryBuilder<SizeModel, SizeModel, QQueryProperty> {
  QueryBuilder<SizeModel, int, QQueryOperations> idLocalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idLocal');
    });
  }

  QueryBuilder<SizeModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SizeModel, String, QQueryOperations> sizeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sizeName');
    });
  }
}
