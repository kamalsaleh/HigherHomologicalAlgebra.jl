```jldoctest AutoDocTests
julia> using CAP, MatricesForHomalg, LinearAlgebraForCAP, AdditiveClosuresForCAP, ComplexesCategories, TriangulatedCategories, HomotopyCategories, DerivedCategories

julia> k = HomalgFieldOfRationals()
Rational field

julia> k_rows = CategoryOfRows( k )
Rows( Q )

julia> K = HomotopyCategoryByCochains( k_rows )
Homotopy category by cochains( Rows( Q ) )

julia> D = DerivedCategoryByCochains( k_rows )
Derived category by cochains( Rows( Q ) )

julia> L = LocalizationFunctor( K )
Localization functor from homotopy category into derived category

julia> o_K = CreateComplex( K,
         [ AsCategoryOfRowsMorphism( k_rows, HomalgMatrix( [ [ 1, 0 ], [ 0, 0 ] ], 2, 2, k ) ),
           AsCategoryOfRowsMorphism( k_rows, HomalgMatrix( [ [ 0, 1 ] ], 1, 2, k ) ) ], 0 )
<An object in Homotopy category by cochains( Rows( Q ) ) supported on the interval [ 0 .. 2 ]>

julia> o_D = L( o_K )
<An object in Derived category by cochains( Rows( Q ) ) supported on the interval [ 0 .. 2 ]>

julia> s = LaTeXOutput( o_D );

julia> occursin( "\\begin{array}{c}", s )
true

julia> occursin( "\\mathbb{Q}", s )
true

julia> occursin( "[array]", s )
false

julia> id_K = IdentityMorphism( o_K );

julia> phi_D = L( id_K );

julia> s2 = LaTeXOutput( phi_D );

julia> occursin( "\\begin{array}{ccccc}", s2 )
true

julia> occursin( "\\leftarrow", s2 )
true

julia> occursin( "[array]", s2 )
false

```
