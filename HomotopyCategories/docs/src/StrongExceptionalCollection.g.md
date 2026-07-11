
```jldoctest AutoDocTests
julia> using CAP, Singular, MatricesForHomalg, LinearAlgebraForCAP, QuotientCategories, LinearClosuresForCAP, AdditiveClosuresForCAP, FpCategories, FpLinearCategories, PresheafCategories, ComplexesCategories, TriangulatedCategories, SubcategoriesForCAP, FreydCategoriesForCAP, FiniteCocompletions, FunctorCategories, HomotopyCategories

julia> q_O = FinQuiver( "q_O(O0,O1,O2)[x0:O0->O1,x1:O0->O1,x2:O0->O1,y0:O1->O2,y1:O1->O2,y2:O1->O2]" )
FinQuiver( "q_O(O0,O1,O2)[x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2]" )

julia> SetLaTeXStringsOfObjects( q_O, [ "\\mathcal[O]_[0]", "\\mathcal[O]_[1]", "\\mathcal[O]_[2]" ] )

julia> SetLaTeXStringsOfMorphisms( q_O, [ "x_0", "x_1", "x_2", "y_0", "y_1", "y_2" ] )

julia> P_O = PathCategory( q_O )
PathCategory( FinQuiver( "q_O(O0,O1,O2)[x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2]" ) )

julia> rho_O = [ [ P_O.x0y1, P_O.x1y0 ], [ P_O.x0y2, P_O.x2y0 ], [ P_O.x1y2, P_O.x2y1 ] ];

julia> ViewObj( rho_O )
[ [ x0⋅y1:(O0) → (O2), x1⋅y0:(O0) → (O2) ], [ x0⋅y2:(O0) → (O2), x2⋅y0:(O0) → (O2) ], [ x1⋅y2:(O0) → (O2), x2⋅y1:(O0) → (O2) ] ]

julia> quotient_P_O = P_O / rho_O
PathCategory( FinQuiver( "q_O(O0,O1,O2)[x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2]" ) ) / [ x0⋅y1 == x1⋅y0, x0⋅y2 == x2⋅y0, x1⋅y2 == x2⋅y1 ]

julia> QQ = HomalgFieldOfRationals( )
Rational field

julia> k = QQ
Rational field

julia> k_quotient_P_O = k[quotient_P_O]
Q-LinearClosure( PathCategory( FinQuiver( "q_O(O0,O1,O2)[x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2]" ) ) / [ x0⋅y1 == x1⋅y0, x0⋅y2 == x2⋅y0, x1⋅y2 == x2⋅y1 ] )

julia> A_O = AlgebroidFromDataTables( k_quotient_P_O )
Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms

julia> phi = 2 * A_O.x0 + 3 * A_O.x1 - A_O.x2
<2*x0 + 3*x1 - 1*x2:(O0) → (O1)>

julia> A_Oadd = AdditiveClosure( A_O )
AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms )

julia> KA_Oadd = HomotopyCategoryByCochains( A_Oadd )
Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) )

julia> E10 = [ A_O.O0, A_O.O0, A_O.O0 ] / A_Oadd
<An object in AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) defined by 3 underlying objects>

julia> E11 = [ A_O.O1, A_O.O1, A_O.O1 ] / A_Oadd
<An object in AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) defined by 3 underlying objects>

julia> E12 = [ A_O.O2 ] / A_Oadd
<An object in AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) defined by 1 underlying objects>

julia> delta_0 = AdditiveClosureMorphism(
                E10,
                [ [ A_O.x1, -A_O.x0, ZeroMorphism(A_O.O0, A_O.O1) ],
                  [ A_O.x2, ZeroMorphism(A_O.O0, A_O.O1), -A_O.x0 ],
                  [ ZeroMorphism(A_O.O0, A_O.O1), A_O.x2, -A_O.x1 ] ],
                E11 )
<A morphism in AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) defined by a 3 x 3 matrix of underlying morphisms>

julia> delta_1 = AdditiveClosureMorphism(
                E11,
                [ [ A_O.y0 ],
                  [ A_O.y1 ],
                  [ A_O.y2 ] ],
                E12 )
<A morphism in AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) defined by a 3 x 1 matrix of underlying morphisms>

julia> E1 = CreateComplex( KA_Oadd, [ delta_0, delta_1 ], 0 )
<An object in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ 0 .. 2 ]>

julia> E20 = [ A_O.O0, A_O.O0, A_O.O0 ] / A_Oadd
<An object in AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) defined by 3 underlying objects>

julia> E21 = [ A_O.O1] / A_Oadd
<An object in AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) defined by 1 underlying objects>

julia> delta_0 = AdditiveClosureMorphism(
              E20,
              [ [ A_O.x0 ],
                [ A_O.x1 ],
                [ A_O.x2 ] ],
              E21 )
<A morphism in AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) defined by a 3 x 1 matrix of underlying morphisms>

julia> E2 = CreateComplex( KA_Oadd, [ delta_0 ], 0 )
<An object in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ 0 .. 1 ]>

julia> E3 = CreateComplex( KA_Oadd, A_O.O0 / A_Oadd, 0 )
<An object in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ 0 ]>

julia> seq = CreateStrongExceptionalSequence( [ E1, E2, E3 ] )
A strong exceptional sequence in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) )

julia> T = DirectSum( [ E1, E2, E3 ] )
<An object in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ 0 .. 2 ]>

julia> RankOfObject( HomStructure( E1, E1 ) ) == 1 &&
          RankOfObject( HomStructure( E2, E2 ) ) == 1 &&
            RankOfObject( HomStructure( E3, E3 ) ) == 1
true

julia> IsZeroForObjects( HomStructure( E3, E2 ) ) &&
          IsZeroForObjects( HomStructure( E2, E1 ) ) &&
            IsZeroForObjects( HomStructure( E3, E1 ) )
true

julia> IsZeroForObjects( HomStructure( T, Shift( T, -2 ) ) ) &&
          IsZeroForObjects( HomStructure( T, Shift( T, -1 ) ) ) &&
            IsZeroForObjects( HomStructure( T, Shift( T, 1 ) ) ) &&
              IsZeroForObjects( HomStructure( T, Shift( T, 2 ) ) )
true

julia> RankOfObject( HomStructure( T, T ) )
12

julia> A_E = AbstractionAlgebroid( seq )
Q-algebroid( [E1,E2,E3][m1_2_1:E1→E2,m1_2_2:E1→E2,m1_2_3:E1→E2,m2_3_1:E2→E3,m2_3_2:E2→E3,m2_3_3:E2→E3] ) defined by 3 objects and 6 generating morphisms

julia> q_E = UnderlyingQuiver( A_E )
FinQuiver( "q(E1,E2,E3)[m1_2_1:E1→E2,m1_2_2:E1→E2,m1_2_3:E1→E2,m2_3_1:E2→E3,m2_3_2:E2→E3,m2_3_3:E2→E3]" )

julia> @Assert( 0, Dimension( A_E ) == 12 )

julia> a = IsomorphismIntoAbstractionAlgebroid( seq )
Isomorphism: strong exceptional sequence ⟶ abstraction algebroid

julia> r = IsomorphismFromAbstractionAlgebroid( seq )
Isomorphism: abstraction algebroid ⟶ strong exceptional sequence

julia> m = A_E["m1_2_1"]
<1*m1_2_1:(E1) → (E2)>

julia> @Assert( 0, m == ApplyFunctor( a, ApplyFunctor( r, m ) ) )

julia> T_E = TriangulatedSubcategory( seq )
TriangulatedSubcategory( A strong exceptional sequence in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) ) )

julia> O0 = CreateComplex( KA_Oadd, A_O["O0"] / A_Oadd, 0 )
<An object in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ 0 ]>

julia> O1 = CreateComplex( KA_Oadd, A_O["O1"] / A_Oadd, 0 )
<An object in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ 0 ]>

julia> O2 = CreateComplex( KA_Oadd, A_O["O2"] / A_Oadd, 0 )
<An object in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ 0 ]>

julia> IsWellDefined( AsSubcategoryCell( T_E, O0 ) ) &&
            IsWellDefined( AsSubcategoryCell( T_E, O1 ) ) &&
                IsWellDefined( AsSubcategoryCell( T_E, O2 ) )
true

julia> G = ReplacementFunctorIntoHomotopyCategoryOfAdditiveClosureOfAbstractionAlgebroid( seq )
Replacement functor

julia> F = ConvolutionFunctorFromHomotopyCategoryOfAdditiveClosureOfAbstractionAlgebroid( seq )
Convolution functor

julia> G_O0 = ApplyFunctor( G, O0 )
<An object in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [E1,E2,E3][m1_2_1:E1→E2,m1_2_2:E1→E2,m1_2_3:E1→E2,m2_3_1:E2→E3,m2_3_2:E2→E3,m2_3_3:E2→E3] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ 0 ]>

julia> G_O1 = ApplyFunctor( G, O1 )
<An object in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [E1,E2,E3][m1_2_1:E1→E2,m1_2_2:E1→E2,m1_2_3:E1→E2,m2_3_1:E2→E3,m2_3_2:E2→E3,m2_3_3:E2→E3] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ -1 .. 0 ]>

julia> G_O2 = ApplyFunctor( G, O2 )
<An object in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [E1,E2,E3][m1_2_1:E1→E2,m1_2_2:E1→E2,m1_2_3:E1→E2,m2_3_1:E2→E3,m2_3_2:E2→E3,m2_3_3:E2→E3] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ -2 .. 0 ]>

julia> epsilon = CounitOfConvolutionReplacementAdjunction( seq )
Counit ϵ; F ∘ G ⟹  Id of the adjunction F ⊣ G

julia> epsilon_O0 = ApplyNaturalTransformation( epsilon, O0 )
<A morphism in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ 0 ]>

julia> epsilon_O1 = ApplyNaturalTransformation( epsilon, O1 )
<A morphism in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ -1 .. 0 ]>

julia> epsilon_O2 = ApplyNaturalTransformation( epsilon, O2 )
<A morphism in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ -2 .. 0 ]>

julia> ForAll( [ epsilon_O0, epsilon_O1, epsilon_O2 ], IsIsomorphism )
true

julia> i = InverseForMorphisms( DirectSumFunctorial( [ epsilon_O0, epsilon_O1, epsilon_O2 ] ) )
<A morphism in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [O0,O1,O2][x0:O0→O1,x1:O0→O1,x2:O0→O1,y0:O1→O2,y1:O1→O2,y2:O1→O2] ) defined by 3 objects and 6 generating morphisms ) ) supported on the interval [ -2 .. 0 ]>

julia> IsWellDefined( i ) && IsIsomorphism( i )
true

```
