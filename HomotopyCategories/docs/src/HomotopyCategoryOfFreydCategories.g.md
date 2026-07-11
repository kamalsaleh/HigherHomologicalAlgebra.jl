```jldoctest AutoDocTests
julia> using CAP, Singular, MatricesForHomalg, LinearAlgebraForCAP, AdditiveClosuresForCAP, LinearClosuresForCAP, FpCategories, FpLinearCategories,ComplexesCategories, TriangulatedCategories, QuotientCategories, SubcategoriesForCAP, FreydCategoriesForCAP, HomotopyCategories

julia> QQ = HomalgFieldOfRationalsInSingular( )
Rational field

julia> QQ_xy = QQ["x", "y"]
Singular polynomial ring (QQ),(x,y),(dp(2),C)

julia> x, y = Indeterminates(QQ_xy)
2-element Vector{spoly{n_Q}}:
 x
 y

julia> QQ_xy_rows = CategoryOfRows( QQ_xy )
Rows( Q[x,y] )

julia> QQ_xy_mod = FreydCategory( QQ_xy_rows )
Freyd( Rows( Q[x,y] ) )

julia> K_QQ_xy_mod = HomotopyCategoryByCochains( QQ_xy_mod )
Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) )

julia> m = HomalgMatrix([[0,0,25*y+9,30,0,0,7*y], [0,0,0,0,24*x,0,20*y], [0,0,0,0,0,24,0], [0,0,29*x+27*y+10,0,0,0,0], [0,0,0,0,34,0,0], [0,0,0,0,0,0,0], [0,0,0,33*y,4*y+12,0,42], [0,20*x+34,0,0,0,0,0], [0,0,0,43*x,0,0,24*y], [0,0,0,0,0,0,0]], 10, 7, QQ_xy );

julia> n = HomalgMatrix([[0,0,25*y+9], [0,0,725*x+7], [0,10*x+17,0]], 3, 3, QQ_xy )
[0, 0, 25*y + 9
0, 0, 725*x + 7
0, 10*x + 17, 0]

julia> M = ObjectConstructor( QQ_xy_mod, m / QQ_xy_rows )
<An object in Freyd( Rows( Q[x,y] ) )>

julia> Display( M )

--------------------------------
Relation morphism:
--------------------------------

Source: 
A row module over Q[x,y] of rank 10

Matrix: 
[0, 0, 25*y + 9, 30, 0, 0, 7*y
0, 0, 0, 0, 24*x, 0, 20*y
0, 0, 0, 0, 0, 24, 0
0, 0, 29*x + 27*y + 10, 0, 0, 0, 0
0, 0, 0, 0, 34, 0, 0
0, 0, 0, 0, 0, 0, 0
0, 0, 0, 33*y, 4*y + 12, 0, 42
0, 20*x + 34, 0, 0, 0, 0, 0
0, 0, 0, 43*x, 0, 0, 24*y
0, 0, 0, 0, 0, 0, 0]

Range: 
A row module over Q[x,y] of rank 7

A morphism in Rows( Q[x,y] )


--------------------------------
General description:
--------------------------------

An object in Freyd( Rows( Q[x,y] ) )


julia> IsZeroForObjects( M )
false

julia> IsProjective( M )
false

julia> N = ObjectConstructor( QQ_xy_mod, n / QQ_xy_rows )
<An object in Freyd( Rows( Q[x,y] ) )>

julia> Display( N )

--------------------------------
Relation morphism:
--------------------------------

Source: 
A row module over Q[x,y] of rank 3

Matrix: 
[0, 0, 25*y + 9
0, 0, 725*x + 7
0, 10*x + 17, 0]

Range: 
A row module over Q[x,y] of rank 3

A morphism in Rows( Q[x,y] )


--------------------------------
General description:
--------------------------------

An object in Freyd( Rows( Q[x,y] ) )


julia> a = HomalgMatrix( [[1,0,0], [0,1,0], [0,0,1], [0,0,-5//6*y-3//10], [0,0,0], [0,0,0], [0,0,0]], 7, 3, QQ_xy )
[1, 0, 0
0, 1, 0
0, 0, 1
0, 0, -5//6*y - 3//10
0, 0, 0
0, 0, 0
0, 0, 0]

julia> alpha = MorphismConstructor( QQ_xy_mod, M, a / QQ_xy_rows, N )
<A morphism in Freyd( Rows( Q[x,y] ) )>

julia> Display( alpha )

--------------------------------
Source:
--------------------------------

Source: 
A row module over Q[x,y] of rank 10

Matrix: 
[0, 0, 25*y + 9, 30, 0, 0, 7*y
0, 0, 0, 0, 24*x, 0, 20*y
0, 0, 0, 0, 0, 24, 0
0, 0, 29*x + 27*y + 10, 0, 0, 0, 0
0, 0, 0, 0, 34, 0, 0
0, 0, 0, 0, 0, 0, 0
0, 0, 0, 33*y, 4*y + 12, 0, 42
0, 20*x + 34, 0, 0, 0, 0, 0
0, 0, 0, 43*x, 0, 0, 24*y
0, 0, 0, 0, 0, 0, 0]

Range: 
A row module over Q[x,y] of rank 7

A morphism in Rows( Q[x,y] )


--------------------------------
Morphism datum:
--------------------------------

Source: 
A row module over Q[x,y] of rank 7

Matrix: 
[1, 0, 0
0, 1, 0
0, 0, 1
0, 0, -5//6*y - 3//10
0, 0, 0
0, 0, 0
0, 0, 0]

Range: 
A row module over Q[x,y] of rank 3

A morphism in Rows( Q[x,y] )


--------------------------------
Range:
--------------------------------

Source: 
A row module over Q[x,y] of rank 3

Matrix: 
[0, 0, 25*y + 9
0, 0, 725*x + 7
0, 10*x + 17, 0]

Range: 
A row module over Q[x,y] of rank 3

A morphism in Rows( Q[x,y] )


--------------------------------
General description:
--------------------------------

A morphism in Freyd( Rows( Q[x,y] ) )


julia> IsIsomorphism( alpha )
true

julia> M = CreateComplex( K_QQ_xy_mod, [ MorphismIntoZeroObject( M ) ], 0 )
<An object in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ 0 .. 1 ]>

julia> ObjectsSupport( M )
1-element Vector{Int64}:
 0

julia> M[0]
<An object in Freyd( Rows( Q[x,y] ) )>

julia> M^0
<A morphism in Freyd( Rows( Q[x,y] ) )>

julia> N = CreateComplex( K_QQ_xy_mod, [ MorphismIntoZeroObject( N ) ], 0 )
<An object in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ 0 .. 1 ]>

julia> ObjectsSupport( N )
1-element Vector{Int64}:
 0

julia> alpha = CreateComplexMorphism( K_QQ_xy_mod, M, [ alpha ], 0, N )
<A morphism in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ 0 .. 1 ]>

julia> p_M = ProjectiveResolution( M, true )
<An object in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ -2 .. 1 ]>

julia> q_M = QuasiIsomorphismFromProjectiveResolution( M, true )
<A morphism in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ -2 .. 1 ]>

julia> p_N = ProjectiveResolution( N, true )
<An object in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ -2 .. 1 ]>

julia> q_N = QuasiIsomorphismFromProjectiveResolution( N, true )
<A morphism in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ -2 .. 1 ]>

julia> p_alpha = MorphismBetweenProjectiveResolutions( alpha, true )
<A morphism in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ -2 .. 1 ]>

julia> IsIsomorphism( p_alpha )
true

julia> p_alpha[0]
<A morphism in Freyd( Rows( Q[x,y] ) )>

julia> PreCompose( p_alpha, q_N ) == PreCompose(q_M, alpha )
true

julia> L = LocalizationFunctorByProjectiveObjects( K_QQ_xy_mod )
Localization functor via projective objects

julia> Display( L )
Localization functor via projective objects:

Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) )
  |
  V
Homotopy category by cochains( FullSubcategoryOfProjectiveObjects( Freyd( Rows( Q[x,y] ) ) ) )

julia> L_M = ApplyFunctor( L, M )
<An object in Homotopy category by cochains( FullSubcategoryOfProjectiveObjects( Freyd( Rows( Q[x,y] ) ) ) ) supported on the interval [ -2 .. 1 ]>

julia> IsIsomorphism( ApplyFunctor( L, alpha ) )
true

julia> cone_q_M = StandardConeObject( q_M )
<An object in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ -3 .. 1 ]>

julia> CohomologySupport( cone_q_M )
Int64[]

julia> iota_q_M = MorphismIntoStandardConeObject( q_M )
<A morphism in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ -3 .. 1 ]>

julia> IsWellDefined( iota_q_M )
true

julia> pi_q_M = MorphismFromStandardConeObject( q_M )
<A morphism in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ -3 .. 1 ]>

julia> IsZeroForMorphisms( PreCompose( iota_q_M, pi_q_M ) )
true

julia> nu = MorphismBetweenStandardConeObjects(q_M, p_alpha, alpha, q_N)
<A morphism in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ -3 .. 1 ]>

julia> IsWellDefined( nu )
true

julia> IsZeroForMorphisms( nu )
false

julia> IsIsomorphism( nu )
true

julia> ShiftOfObjectByInteger( p_M, 2 )
<An object in Homotopy category by cochains( Freyd( Rows( Q[x,y] ) ) ) supported on the interval [ -4 .. -1 ]>

```
