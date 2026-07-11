
```jldoctest
julia> using MatricesForHomalg, CAP, ComplexesCategories, FpCategories, FpLinearCategories, AdditiveClosuresForCAP, FreydCategoriesForCAP, Bicomplexes


julia> true
true

julia> true
true

julia> zz = HomalgRingOfIntegers( );

julia> rows_zz = CategoryOfRows( zz );

julia> lp = FreydCategory( rows_zz );

julia> bicomplexes_cat = BicomplexesCategoryByChains( lp );

julia> modeling_category = ModelingCategory( bicomplexes_cat );

julia> complexes_cat = UnderlyingCategory( modeling_category );

julia> F1 = AsFreydCategoryObject( CategoryOfRowsObject( 1, rows_zz ) );

julia> d7 = FreydCategoryMorphism( F1, AsCategoryOfRowsMorphism( HomalgMatrix( [ [ 4 ] ], 1, 1, zz ), rows_zz ), F1 );

julia> d6 = CokernelProjection( d7 );

julia> C10 = CreateComplex( complexes_cat, [ d6, d7 ], 6 );

julia> t7 = FreydCategoryMorphism( F1, AsCategoryOfRowsMorphism( HomalgMatrix( [ [ 2 ] ], 1, 1, zz ), rows_zz ), F1 );

julia> t6 = CokernelProjection( t7 );

julia> C9 = CreateComplex( complexes_cat, [ t6, t7 ], 6 );

julia> phi5 = FreydCategoryMorphism( C10[ 5 ], AsCategoryOfRowsMorphism( HomalgIdentityMatrix( 1, zz ), rows_zz ), C9[ 5 ] );

julia> phi6 = FreydCategoryMorphism( F1, AsCategoryOfRowsMorphism( HomalgIdentityMatrix( 1, zz ), rows_zz ), F1 );

julia> phi7 = FreydCategoryMorphism( F1, AsCategoryOfRowsMorphism( 2 * HomalgIdentityMatrix( 1, zz ), rows_zz ), F1 );

julia> phi = CreateComplexMorphism( C10, [ phi5, phi6, phi7 ], 5, C9 );

julia> o = CreateComplex( modeling_category, [ phi ], 10 );

julia> bicomplex = ReinterpretationOfObject( bicomplexes_cat, o );

julia> t = TotalComplex( bicomplex );

julia> @Assert( 0, IsWellDefined( t ) && IsExact( t ) )

```

