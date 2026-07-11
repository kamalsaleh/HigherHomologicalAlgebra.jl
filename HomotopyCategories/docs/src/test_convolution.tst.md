

```jldoctest
julia> using CAP, Singular, MatricesForHomalg, LinearAlgebraForCAP, AdditiveClosuresForCAP, LinearClosuresForCAP, FpCategories, FpLinearCategories, ComplexesCategories, TriangulatedCategories, QuotientCategories, SubcategoriesForCAP, FreydCategoriesForCAP, HomotopyCategories

julia> true
true

julia> true
true

julia> k = HomalgFieldOfRationals( );

julia> objects = [ [ "A", [ -2, 2 ] ], [ "B", [ -2, 2 ] ], [ "C", [ -2, 2 ] ], [ "D", [ -2, 2 ] ], [ "E", [ -2, 2 ] ] ];

julia> morphisms = [ [ "h0A",  [ 1, 2 ],  0, [-2, 2 ], "h_[0,A]" ],
                           [ "h0B",  [ 2, 3 ],  0, [-2, 2 ], "h_[0,B]" ],
                           [ "h0C",  [ 3, 4 ],  0, [-2, 2 ], "h_[0,C]" ],
                           [ "h0D",  [ 4, 5 ],  0, [-2, 2 ], "h_[0,D]" ],
                           [ "h1A", [ 1, 3 ], -1, [ -1, 2 ], "h_[1,A]" ],
                           [ "h1B", [ 2, 4 ], -1, [ -1, 2 ], "h_[1,B]" ],
                           [ "h1C", [ 3, 5 ], -1, [ -1, 2 ], "h_[1,C]" ],
                           [ "h2A", [ 1, 4 ], -2, [ 0, 2 ], "h_[2,A]" ],
                           [ "h2B", [ 2, 5 ], -2, [ 0, 2 ], "h_[2,B]" ],
                           [ "h3A", [ 1, 5 ], -3, [ 1, 2 ], "h_[3,A]" ]
                         ];

julia> relations = [ [ "Differential( h0A )", 1 ],
                           [ "Differential( h0B )", 2 ],
                           [ "Differential( h0C )", 3 ],
                           [ "Differential( h0D )", 4 ],
                           [ "PreCompose( h0A, h0B ) - Differential( h1A )", 1 ],
                           [ "PreCompose( h0B, h0C ) - Differential( h1B )", 2 ],
                           [ "PreCompose( h0C, h0D ) - Differential( h1C )", 3 ],
                           [ "PreCompose( h0A, h1B ) - PreCompose( h1A, h0C ) - Differential( h2A )", 1 ],
                           [ "PreCompose( h0B, h1C ) - PreCompose( h1B, h0D ) - Differential( h2B )", 2 ],
                           [ "PreCompose( h0A, h2B ) - PreCompose( h1A, h1C ) + PreCompose( h2A, h0D ) - Differential( h3A )", 1 ],
                         ];

julia> q = FinQuiver( "q(A_m2,A_m1,A_0,A_1,A_2,B_m2,B_m1,B_0,B_1,B_2,C_m2,C_m1,C_0,C_1,C_2,D_m2,D_m1,D_0,D_1,D_2,E_m2,E_m1,E_0,E_1,E_2)[dA_m2:A_m2->A_m1,dA_m1:A_m1->A_0,dA_0:A_0->A_1,dA_1:A_1->A_2,dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,dC_m2:C_m2->C_m1,dC_m1:C_m1->C_0,dC_0:C_0->C_1,dC_1:C_1->C_2,dD_m2:D_m2->D_m1,dD_m1:D_m1->D_0,dD_0:D_0->D_1,dD_1:D_1->D_2,dE_m2:E_m2->E_m1,dE_m1:E_m1->E_0,dE_0:E_0->E_1,dE_1:E_1->E_2,h0A_m2:A_m2->B_m2,h0A_m1:A_m1->B_m1,h0A_0:A_0->B_0,h0A_1:A_1->B_1,h0A_2:A_2->B_2,h0B_m2:B_m2->C_m2,h0B_m1:B_m1->C_m1,h0B_0:B_0->C_0,h0B_1:B_1->C_1,h0B_2:B_2->C_2,h0C_m2:C_m2->D_m2,h0C_m1:C_m1->D_m1,h0C_0:C_0->D_0,h0C_1:C_1->D_1,h0C_2:C_2->D_2,h0D_m2:D_m2->E_m2,h0D_m1:D_m1->E_m1,h0D_0:D_0->E_0,h0D_1:D_1->E_1,h0D_2:D_2->E_2,h1A_m1:A_m1->C_m2,h1A_0:A_0->C_m1,h1A_1:A_1->C_0,h1A_2:A_2->C_1,h1B_m1:B_m1->D_m2,h1B_0:B_0->D_m1,h1B_1:B_1->D_0,h1B_2:B_2->D_1,h1C_m1:C_m1->E_m2,h1C_0:C_0->E_m1,h1C_1:C_1->E_0,h1C_2:C_2->E_1,h2A_0:A_0->D_m2,h2A_1:A_1->D_m1,h2A_2:A_2->D_0,h2B_0:B_0->E_m2,h2B_1:B_1->E_m1,h2B_2:B_2->E_0,h3A_1:A_1->E_m2,h3A_2:A_2->E_m1]" );

julia> o = [ "A^[-2]", "A^[-1]", "A^[0]", "A^[1]", "A^[2]", "B^[-2]", "B^[-1]", "B^[0]", "B^[1]", "B^[2]", "C^[-2]", "C^[-1]", "C^[0]", "C^[1]", "C^[2]", "D^[-2]", "D^[-1]", "D^[0]", "D^[1]", "D^[2]", "E^[-2]", "E^[-1]", "E^[0]", "E^[1]", "E^[2]" ];

julia> m = [ "\\partial_[A]^[-2]", "\\partial_[A]^[-1]", "\\partial_[A]^[0]", "\\partial_[A]^[1]", "\\partial_[B]^[-2]", "\\partial_[B]^[-1]", "\\partial_[B]^[0]", "\\partial_[B]^[1]", "\\partial_[C]^[-2]", "\\partial_[C]^[-1]", "\\partial_[C]^[0]", "\\partial_[C]^[1]", "\\partial_[D]^[-2]", "\\partial_[D]^[-1]", "\\partial_[D]^[0]", "\\partial_[D]^[1]", "\\partial_[E]^[-2]", "\\partial_[E]^[-1]", "\\partial_[E]^[0]", "\\partial_[E]^[1]", "h_[0,A]^[-2]", "h_[0,A]^[-1]", "h_[0,A]^[0]", "h_[0,A]^[1]", "h_[0,A]^[2]", "h_[0,B]^[-2]", "h_[0,B]^[-1]", "h_[0,B]^[0]", "h_[0,B]^[1]", "h_[0,B]^[2]", "h_[0,C]^[-2]", "h_[0,C]^[-1]", "h_[0,C]^[0]", "h_[0,C]^[1]", "h_[0,C]^[2]", "h_[0,D]^[-2]", "h_[0,D]^[-1]", "h_[0,D]^[0]", "h_[0,D]^[1]", "h_[0,D]^[2]", "h_[1,A]^[-1]", "h_[1,A]^[0]", "h_[1,A]^[1]", "h_[1,A]^[2]", "h_[1,B]^[-1]", "h_[1,B]^[0]", "h_[1,B]^[1]", "h_[1,B]^[2]", "h_[1,C]^[-1]", "h_[1,C]^[0]", "h_[1,C]^[1]", "h_[1,C]^[2]", "h_[2,A]^[0]", "h_[2,A]^[1]", "h_[2,A]^[2]", "h_[2,B]^[0]", "h_[2,B]^[1]", "h_[2,B]^[2]", "h_[3,A]^[1]", "h_[3,A]^[2]" ];

julia> SetLaTeXStringsOfObjects( q, o );

julia> SetLaTeXStringsOfMorphisms( q, m );

julia> F = PathCategory( q );

julia> kF = k[F];

julia> rels = [
           PreCompose( kF.dA_m2, kF.dA_m1 ),
           PreCompose( kF.dA_m1, kF.dA_0 ),
           PreCompose( kF.dA_0, kF.dA_1 ),
           PreCompose( kF.dB_m2, kF.dB_m1 ),
           PreCompose( kF.dB_m1, kF.dB_0 ),
           PreCompose( kF.dB_0, kF.dB_1 ),
           PreCompose( kF.dC_m2, kF.dC_m1 ),
           PreCompose( kF.dC_m1, kF.dC_0 ),
           PreCompose( kF.dC_0, kF.dC_1 ),
           PreCompose( kF.dD_m2, kF.dD_m1 ),
           PreCompose( kF.dD_m1, kF.dD_0 ),
           PreCompose( kF.dD_0, kF.dD_1 ),
           PreCompose( kF.dE_m2, kF.dE_m1 ),
           PreCompose( kF.dE_m1, kF.dE_0 ),
           PreCompose( kF.dE_0, kF.dE_1 ),
           -PreCompose( kF.h0A_m2, kF.dB_m2 ) + PreCompose( kF.dA_m2, kF.h0A_m1 ),
           -PreCompose( kF.h0A_m1, kF.dB_m1 ) + PreCompose( kF.dA_m1, kF.h0A_0 ),
           -PreCompose( kF.h0A_0, kF.dB_0 ) + PreCompose( kF.dA_0, kF.h0A_1 ),
           -PreCompose( kF.h0A_1, kF.dB_1 ) + PreCompose( kF.dA_1, kF.h0A_2 ),
           -PreCompose( kF.h0B_m2, kF.dC_m2 ) + PreCompose( kF.dB_m2, kF.h0B_m1 ),
           -PreCompose( kF.h0B_m1, kF.dC_m1 ) + PreCompose( kF.dB_m1, kF.h0B_0 ),
           -PreCompose( kF.h0B_0, kF.dC_0 ) + PreCompose( kF.dB_0, kF.h0B_1 ),
           -PreCompose( kF.h0B_1, kF.dC_1 ) + PreCompose( kF.dB_1, kF.h0B_2 ),
           -PreCompose( kF.h0C_m2, kF.dD_m2 ) + PreCompose( kF.dC_m2, kF.h0C_m1 ),
           -PreCompose( kF.h0C_m1, kF.dD_m1 ) + PreCompose( kF.dC_m1, kF.h0C_0 ),
           -PreCompose( kF.h0C_0, kF.dD_0 ) + PreCompose( kF.dC_0, kF.h0C_1 ),
           -PreCompose( kF.h0C_1, kF.dD_1 ) + PreCompose( kF.dC_1, kF.h0C_2 ),
           -PreCompose( kF.h0D_m2, kF.dE_m2 ) + PreCompose( kF.dD_m2, kF.h0D_m1 ),
           -PreCompose( kF.h0D_m1, kF.dE_m1 ) + PreCompose( kF.dD_m1, kF.h0D_0 ),
           -PreCompose( kF.h0D_0, kF.dE_0 ) + PreCompose( kF.dD_0, kF.h0D_1 ),
           -PreCompose( kF.h0D_1, kF.dE_1 ) + PreCompose( kF.dD_1, kF.h0D_2 ),
           PreCompose( kF.h0A_m2, kF.h0B_m2 ) - PreCompose( kF.dA_m2, kF.h1A_m1 ),
           -PreCompose( kF.h1A_m1, kF.dC_m2 ) + PreCompose( kF.h0A_m1, kF.h0B_m1 ) - PreCompose( kF.dA_m1, kF.h1A_0 ),
           -PreCompose( kF.h1A_0, kF.dC_m1 ) + PreCompose( kF.h0A_0, kF.h0B_0 ) - PreCompose( kF.dA_0, kF.h1A_1 ),
           -PreCompose( kF.h1A_1, kF.dC_0 ) + PreCompose( kF.h0A_1, kF.h0B_1 ) - PreCompose( kF.dA_1, kF.h1A_2 ),
           -PreCompose( kF.h1A_2, kF.dC_1 ) + PreCompose( kF.h0A_2, kF.h0B_2 ),
           PreCompose( kF.h0B_m2, kF.h0C_m2 ) - PreCompose( kF.dB_m2, kF.h1B_m1 ),
           -PreCompose( kF.h1B_m1, kF.dD_m2 ) + PreCompose( kF.h0B_m1, kF.h0C_m1 ) - PreCompose( kF.dB_m1, kF.h1B_0 ),
           -PreCompose( kF.h1B_0, kF.dD_m1 ) + PreCompose( kF.h0B_0, kF.h0C_0 ) - PreCompose( kF.dB_0, kF.h1B_1 ),
           -PreCompose( kF.h1B_1, kF.dD_0 ) + PreCompose( kF.h0B_1, kF.h0C_1 ) - PreCompose( kF.dB_1, kF.h1B_2 ),
           -PreCompose( kF.h1B_2, kF.dD_1 ) + PreCompose( kF.h0B_2, kF.h0C_2 ),
           PreCompose( kF.h0C_m2, kF.h0D_m2 ) - PreCompose( kF.dC_m2, kF.h1C_m1 ),
           -PreCompose( kF.h1C_m1, kF.dE_m2 ) + PreCompose( kF.h0C_m1, kF.h0D_m1 ) - PreCompose( kF.dC_m1, kF.h1C_0 ),
           -PreCompose( kF.h1C_0, kF.dE_m1 ) + PreCompose( kF.h0C_0, kF.h0D_0 ) - PreCompose( kF.dC_0, kF.h1C_1 ),
           -PreCompose( kF.h1C_1, kF.dE_0 ) + PreCompose( kF.h0C_1, kF.h0D_1 ) - PreCompose( kF.dC_1, kF.h1C_2 ),
           -PreCompose( kF.h1C_2, kF.dE_1 ) + PreCompose( kF.h0C_2, kF.h0D_2 ),
           -PreCompose( kF.h1A_m1, kF.h0C_m2 ) + PreCompose( kF.h0A_m1, kF.h1B_m1 ) - PreCompose( kF.dA_m1, kF.h2A_0 ),
           PreCompose( kF.h2A_0, kF.dD_m2 ) - PreCompose( kF.h1A_0, kF.h0C_m1 ) + PreCompose( kF.h0A_0, kF.h1B_0 ) - PreCompose( kF.dA_0, kF.h2A_1 ),
           PreCompose( kF.h2A_1, kF.dD_m1 ) - PreCompose( kF.h1A_1, kF.h0C_0 ) + PreCompose( kF.h0A_1, kF.h1B_1 ) - PreCompose( kF.dA_1, kF.h2A_2 ),
           PreCompose( kF.h2A_2, kF.dD_0 ) - PreCompose( kF.h1A_2, kF.h0C_1 ) + PreCompose( kF.h0A_2, kF.h1B_2 ),
           -PreCompose( kF.h1B_m1, kF.h0D_m2 ) + PreCompose( kF.h0B_m1, kF.h1C_m1 ) - PreCompose( kF.dB_m1, kF.h2B_0 ),
           PreCompose( kF.h2B_0, kF.dE_m2 ) - PreCompose( kF.h1B_0, kF.h0D_m1 ) + PreCompose( kF.h0B_0, kF.h1C_0 ) - PreCompose( kF.dB_0, kF.h2B_1 ),
           PreCompose( kF.h2B_1, kF.dE_m1 ) - PreCompose( kF.h1B_1, kF.h0D_0 ) + PreCompose( kF.h0B_1, kF.h1C_1 ) - PreCompose( kF.dB_1, kF.h2B_2 ),
           PreCompose( kF.h2B_2, kF.dE_0 ) - PreCompose( kF.h1B_2, kF.h0D_1 ) + PreCompose( kF.h0B_2, kF.h1C_2 ),
           PreCompose( kF.h2A_0, kF.h0D_m2 ) - PreCompose( kF.h1A_0, kF.h1C_m1 ) + PreCompose( kF.h0A_0, kF.h2B_0 ) - PreCompose( kF.dA_0, kF.h3A_1 ),
           -PreCompose( kF.h3A_1, kF.dE_m2 ) + PreCompose( kF.h2A_1, kF.h0D_m1 ) - PreCompose( kF.h1A_1, kF.h1C_0 ) + PreCompose( kF.h0A_1, kF.h2B_1 ) - PreCompose( kF.dA_1, kF.h3A_2 ),
           -PreCompose( kF.h3A_2, kF.dE_m1 ) + PreCompose( kF.h2A_2, kF.h0D_0 ) - PreCompose( kF.h1A_2, kF.h1C_1 ) + PreCompose( kF.h0A_2, kF.h2B_2 ) ];

julia> oid = AlgebroidFromDataTables( kF / rels );

julia> cat = AdditiveClosure( oid );

julia> homotopy_cat = HomotopyCategoryByCochains( cat );

julia> complex_cat = AmbientCategory( homotopy_cat );

julia> A = ObjectConstructor( homotopy_cat,
                  CreateComplex( complex_cat,
                    List( [ oid.dA_m2, oid.dA_m1, oid.dA_0, oid.dA_1 ], m -> m / cat ),
                    -2 ) );

julia> B = ObjectConstructor( homotopy_cat,
                  CreateComplex( complex_cat,
                    List( [ oid.dB_m2, oid.dB_m1, oid.dB_0, oid.dB_1 ], m -> m / cat ),
                    -2 ) );

julia> C = ObjectConstructor( homotopy_cat,
                  CreateComplex( complex_cat,
                    List( [ oid.dC_m2, oid.dC_m1, oid.dC_0, oid.dC_1 ], m -> m / cat ),
                    -2 ) );

julia> D = ObjectConstructor( homotopy_cat,
                  CreateComplex( complex_cat,
                    List( [ oid.dD_m2, oid.dD_m1, oid.dD_0, oid.dD_1 ], m -> m / cat ),
                    -2 ) );

julia> E_ = ObjectConstructor( homotopy_cat,
                  CreateComplex( complex_cat,
                    List( [ oid.dE_m2, oid.dE_m1, oid.dE_0, oid.dE_1 ], m -> m / cat ),
                    -2 ) );

julia> h0A = MorphismConstructor( homotopy_cat,
                    A,
                    CreateComplexMorphism( complex_cat,
                      UnderlyingCell( A ),
                      List( [ oid.h0A_m2, oid.h0A_m1, oid.h0A_0, oid.h0A_1, oid.h0A_2 ], m -> m / cat ),
                      -2,
                      UnderlyingCell( B ) ),
                    B );

julia> h0B = MorphismConstructor( homotopy_cat,
                    B,
                    CreateComplexMorphism( complex_cat,
                      UnderlyingCell( B ),
                      List( [ oid.h0B_m2, oid.h0B_m1, oid.h0B_0, oid.h0B_1, oid.h0B_2 ], m -> m / cat ),
                      -2,
                      UnderlyingCell( C ) ),
                    C );

julia> h0C = MorphismConstructor( homotopy_cat,
                    C,
                    CreateComplexMorphism( complex_cat,
                      UnderlyingCell( C ),
                      List( [ oid.h0C_m2, oid.h0C_m1, oid.h0C_0, oid.h0C_1, oid.h0C_2 ], m -> m / cat ),
                      -2,
                      UnderlyingCell( D ) ),
                    D );

julia> h0D = MorphismConstructor( homotopy_cat,
                    D,
                    CreateComplexMorphism( complex_cat,
                      UnderlyingCell( D ),
                      List( [ oid.h0D_m2, oid.h0D_m1, oid.h0D_0, oid.h0D_1, oid.h0D_2 ], m -> m / cat ),
                      -2,
                      UnderlyingCell( E_ ) ),
                    E_ );

julia> homotopy_cat_of_homotopy_cat = HomotopyCategoryByCochains( homotopy_cat );

julia> T = CreateComplex( homotopy_cat_of_homotopy_cat, [ h0A, h0B, h0C, h0D ], 0 );

julia> conv_T = Convolution( T );

julia> IsWellDefined( conv_T )
true

```
