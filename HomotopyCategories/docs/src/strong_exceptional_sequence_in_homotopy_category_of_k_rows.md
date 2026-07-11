```jldoctest AutoDocTests
julia> using CAP, MatricesForHomalg, LinearAlgebraForCAP, AdditiveClosuresForCAP, LinearClosuresForCAP, FpCategories, FpLinearCategories,ComplexesCategories, TriangulatedCategories, QuotientCategories, SubcategoriesForCAP, FreydCategoriesForCAP, HomotopyCategories

julia> ℚ = HomalgFieldOfRationals()
Rational field

julia> ℚ₋rows = CategoryOfRows( ℚ )
Rows( Q )

julia> 𝓒ᵇℚ₋rows = ComplexesCategoryByCochains( ℚ₋rows )
Complexes category by cochains( Rows( Q ) )

julia> 𝓚ᵇℚ₋rows = HomotopyCategoryByCochains( ℚ₋rows )
Homotopy category by cochains( Rows( Q ) )

julia> E = 1 / ℚ₋rows / 𝓒ᵇℚ₋rows / 𝓚ᵇℚ₋rows
<An object in Homotopy category by cochains( Rows( Q ) ) supported on the interval [ 0 ]>

julia> 𝓔 = CreateStrongExceptionalSequence( [ E ] )
A strong exceptional sequence in Homotopy category by cochains( Rows( Q ) )

julia> 𝐀_𝓔 = AbstractionAlgebroid( 𝓔 )
Q-algebroid( [E1][] ) defined by 1 object and 0 generating morphisms

julia> 𝔾 = ReplacementFunctorIntoHomotopyCategoryOfAdditiveClosureOfAbstractionAlgebroid( 𝓔 )
Replacement functor

julia> Display( 𝔾 )
Replacement functor:

Homotopy category by cochains( Rows( Q ) )
  |
  V
Homotopy category by cochains( AdditiveClosure( Q-algebroid( [E1][] ) defined by 1 object and 0 generating morphisms ) )

julia> 𝔽 = ConvolutionFunctorFromHomotopyCategoryOfAdditiveClosureOfAbstractionAlgebroid( 𝓔 )
Convolution functor

julia> Display( 𝔽 )
Convolution functor:

Homotopy category by cochains( AdditiveClosure( Q-algebroid( [E1][] ) defined by 1 object and 0 generating morphisms ) )
  |
  V
Homotopy category by cochains( Rows( Q ) )

julia> ∂⁰ = AsCategoryOfRowsMorphism( ℚ₋rows,
                   HomalgMatrix(
                      [ [ 0, 1//2, 0, -2, 1, -2, 5//3 ] ], 1, 7, ℚ ) )
<A morphism in Rows( Q )>

julia> ∂¹ = AsCategoryOfRowsMorphism( ℚ₋rows,
                   HomalgMatrix(
                      [ [   -2,   0,-3//2,    -1,  -4,  3//2,    -1 ],
                        [    2,34//3,-4//5,287//15,-5//3,-19//6,-226//9 ],
                        [    0,   0,  -1,     0,   1,    0,   3//4 ],
                        [ -1//6,   0,   0,     1,  -1,   -4,  -1//2 ],
                        [    0,  -4,-3//5,  -1//2,  -2,   -4,    -1 ],
                        [  2//3,   0,-1//2,   1//5,   0,    1,    -6 ],
                        [    0,  -1,   0,    -4, 1//2, -1//4,   1//3 ] ], 7, 7, ℚ ) )
<A morphism in Rows( Q )>

julia> ∂² = AsCategoryOfRowsMorphism( ℚ₋rows,
                   HomalgMatrix(
                      [ [ 0, 0, 0,   -8797355//715374 ],
                        [ 0, 0, 0, -21216095//8584488 ],
                        [ 0, 0, 0,   3869750//1073061 ],
                        [ 0, 0, 0,   1180000//1073061 ],
                        [ 0, 0, 0,  20844305//4292244 ],
                        [ 0, 0, 0,   -234380//1073061 ],
                        [ 0, 0, 0,              -5//3 ] ], 7, 4, ℚ ) )
<A morphism in Rows( Q )>

julia> ∂³ = AsCategoryOfRowsMorphism( ℚ₋rows,
                   HomalgMatrix(
                      [ [    1 ],
                        [ 1//3 ],
                        [   -3 ],
                        [    0 ] ], 4, 1, ℚ ) )
<A morphism in Rows( Q )>

julia> A = CreateComplex( 𝓚ᵇℚ₋rows, [ ∂⁰, ∂¹, ∂², ∂³ ], 0 )
<An object in Homotopy category by cochains( Rows( Q ) ) supported on the interval [ 0 .. 4 ]>

julia> 𝔾A = 𝔾( A )
<An object in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [E1][] ) defined by 1 object and 0 generating morphisms ) ) supported on the interval [ 3 ]>

julia> Display( 𝔾A )
== 3 =======================
A formal direct sum consisting of 2 objects.
<(E1)>
<(E1)>
============================


An object in Homotopy category by cochains( AdditiveClosure( Q-algebroid( [E1][] ) defined by 1 object and 0 generating morphisms ) ) defined by the above data

julia> # The above tells us the the complex A is isomorphic to a direct sum of the only object in the exceptional sequence with itself.

julia> ϵ = CounitOfConvolutionReplacementAdjunction( 𝓔 )
Counit ϵ; F ∘ G ⟹  Id of the adjunction F ⊣ G

julia> ϵ_A = ϵ( A )
<A morphism in Homotopy category by cochains( Rows( Q ) ) supported on the interval [ 0 .. 4 ]>

julia> Display( Source( ϵ_A ) )
== 3 =======================
A row module over Q of rank 2
============================


An object in Homotopy category by cochains( Rows( Q ) ) defined by the above data

julia> IsIsomorphism( ϵ_A )
true

julia> ϵ⁻¹_A = InverseForMorphisms( ϵ_A )
<A morphism in Homotopy category by cochains( Rows( Q ) ) supported on the interval [ 0 .. 4 ]>

```
