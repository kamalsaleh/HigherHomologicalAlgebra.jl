
```jldoctest
julia> using MatricesForHomalg, CAP, SubcategoriesForCAP, LinearAlgebraForCAP, FpCategories, FpLinearCategories, LinearClosuresForCAP, AdditiveClosuresForCAP, FreydCategoriesForCAP, PresheafCategories, FunctorCategories, TriangulatedCategories, ComplexesCategories, HomotopyCategories, DerivedCategories


julia> true
true

julia> true
true

julia> q = FinQuiver( "q(v1,v2,v3,v4)[a:v1->v2,b:v2->v4,c:v1->v3,d:v3->v4]" );

julia> k = HomalgFieldOfRationals( );

julia> F_q = PathCategory( q );

julia> kF_q = k[F_q];

julia> rho = [ PreCompose( kF_q.a, kF_q.b ) - PreCompose( kF_q.c, kF_q.d ) ];

julia> B =  kF_q / rho;

julia> IsAdmissibleAlgebroid( B );

julia> B = AlgebroidFromDataTables( B );

julia> @Assert( 0, IsAdmissibleAlgebroid( B ) );

julia> AB = AdditiveClosure( B );

julia> K_AB = HomotopyCategoryByCochains( AB );

julia> coPSh_B = CoPreSheaves( B; overhead = false );

julia> K_coPSh_B = HomotopyCategoryByCochains( coPSh_B; overhead = false );

julia> D_coPSh_B = DerivedCategoryByCochains( coPSh_B; overhead = false );

julia> I = ExtendFunctorToAdditiveClosureOfSource( CoYonedaEmbedding( B ) );

julia> P1 = I( [ B["v1"] ] / AB );

julia> P2 = I( [ B["v2"] ] / AB );

julia> P3 = I( [ B["v3"] ] / AB );

julia> P4 = I( [ B["v4"] ] / AB );

julia> f = AdditiveClosureMorphism( [ B["v2"], B["v3"] ] / AB, [ [ B["b"] ], [ B["d"] ] ], [ B["v4"] ] / AB );

julia> U = KernelObject( I( f ) );

julia> seq = CreateStrongExceptionalSequence( [ P1, U, P2, P3 ] );

julia> seq_oid = AbstractionAlgebroid( seq );

julia> @Assert( 0, Dimension( seq_oid ) == 9 )

julia> H = ExtendFunctorToHomotopyCategoriesByCochains( HomFunctorOfStrongExceptionalSequence( seq ) );

julia> T = ExtendFunctorToHomotopyCategoriesByCochains( TensorProductFunctorOfStrongExceptionalSequence( seq ) );

julia> epsilon = ExtendNaturalTransformationToHomotopyCategoriesByCochains( CounitOfTensorHomAdjunction( seq ) );

julia> KP4 = CreateComplex( K_coPSh_B, P4, 0 );

julia> @Assert( 0, IsQuasiIsomorphism( PreCompose( T(QuasiIsomorphismFromProjectiveResolution( H( KP4 ), true )), epsilon( KP4 ) ) ) )

julia> K_PSh = RangeOfFunctor( H );

julia> PSh = DefiningCategory( K_PSh );

julia> D = EquivalenceFromFullSubcategoryOfProjectivesObjectsIntoAdditiveClosureOfSource( PSh );

julia> D = ExtendFunctorToHomotopyCategoriesByCochains( D );

julia> L = LocalizationFunctorByProjectiveObjects( K_PSh );

julia> Q = D( L( H( KP4 ) ) );

julia> @Assert( 0, IsWellDefined( Q ) )

julia> @Assert( 0, RankOfObject( HomStructure( Q, Q ) ) == 1 )

julia> W = CreateComplex( K_coPSh_B, DirectSum( [ P1, U, P2, P3 ] ), 0 ) / D_coPSh_B;

julia> @Assert( 0, RankOfObject( HomStructure( W, W ) ) == 9 )

julia> @Assert( 0, IsZeroForObjects( HomStructure( Shift( W, 1 ), W ) ) && IsZeroForObjects( HomStructure( Shift( W, -1 ), W ) ) )

julia> basis = BasisOfExternalHom( W, W );

julia> @Assert( 0, ForAll( basis, IsWellDefined ) )

julia> @Assert( 0, IsCongruentForMorphisms( basis[1] + basis[2] - basis[1], basis[2] ) )

julia> @Assert( 0, HomStructure( PreCompose( [ basis[1], basis[2], basis[3] ] ) ) == PreCompose( HomStructure( basis[2] ), HomStructure( basis[1], basis[3] ) ) )

julia> @Assert( 0, CoefficientsOfMorphism( Sum( basis ) ) == [ 1, 1, 1, 1, 1, 1, 1, 1, 1 ] )

julia> # @drop_example_in_Julia

```
