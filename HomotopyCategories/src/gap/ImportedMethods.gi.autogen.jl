# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#
#####################################################################


##
@InstallMethod( ProjectiveResolution,
          [ IsHomotopyCategoryObject ],
    a -> ProjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a )
);

##
@InstallMethod( ProjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
    ( a, bool ) -> ProjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a )
);

##
@InstallMethod( QuasiIsomorphismFromProjectiveResolution,
          [ IsHomotopyCategoryObject ],
    a -> QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a )
);

##
@InstallMethod( QuasiIsomorphismFromProjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
    ( a, bool ) -> QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a )
);

##
@InstallMethod( MorphismBetweenProjectiveResolutions,
          [ IsHomotopyCategoryMorphism ],
    alpha -> MorphismBetweenProjectiveResolutions( UnderlyingCell( alpha ) ) / CapCategory( alpha )
);

##
@InstallMethod( MorphismBetweenProjectiveResolutions,
          [ IsHomotopyCategoryMorphism, IsBool ],
    ( alpha, bool ) -> MorphismBetweenProjectiveResolutions( UnderlyingCell( alpha ), bool ) / CapCategory( alpha )
);

##
@InstallMethod( InjectiveResolution,
          [ IsHomotopyCategoryObject ],
    a -> InjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a )
);

##
@InstallMethod( InjectiveChainResolution,
          [ IsHomotopyCategoryObject ],
  InjectiveResolution );

##
@InstallMethod( InjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
    ( a, bool ) -> InjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a )
);

##
@InstallMethod( InjectiveChainResolution,
          [ IsHomotopyCategoryObject, IsBool ],
  InjectiveResolution );

##
@InstallMethod( MorphismBetweenInjectiveResolutions,
          [ IsHomotopyCategoryMorphism ],
    alpha -> MorphismBetweenInjectiveResolutions( UnderlyingCell( alpha ) ) / CapCategory( alpha )
);

##
@InstallMethod( MorphismBetweenInjectiveResolutions,
          [ IsHomotopyCategoryMorphism, IsBool ],
    ( alpha, bool ) -> MorphismBetweenInjectiveResolutions( UnderlyingCell( alpha ), bool ) / CapCategory( alpha )
);

##
@InstallMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsHomotopyCategoryObject ],
    a -> QuasiIsomorphismIntoInjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a )
);

##
@InstallMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
    ( a, bool ) -> QuasiIsomorphismIntoInjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a )
);

##
@InstallMethod( CohomologyAt,
          [ IsHomotopyCategoryObject, IsInt ],
    ( a, i ) -> CohomologyAt( UnderlyingCell( a ), i )
);

##
@InstallMethod( ComputedCohomologyAts,
          [ IsHomotopyCategoryObject ],
    a -> ComputedCohomologyAts( UnderlyingCell( a ) )
);

##
@InstallMethod( CohomologyFunctorialAt,
          [ IsHomotopyCategoryMorphism, IsInt ],
    ( alpha, i ) -> CohomologyFunctorialAt( UnderlyingCell( alpha ), i )
);

##
@InstallMethod( ComputedCohomologyFunctorialAts,
          [ IsHomotopyCategoryMorphism ],
    a -> ComputedCohomologyFunctorialAts( UnderlyingCell( a ) )
);


##
@InstallMethod( HomologyAt,
          [ IsHomotopyCategoryObject, IsInt ],
    ( a, i ) -> HomologyAt( UnderlyingCell( a ), i )
);

##
@InstallMethod( ComputedHomologyAts,
          [ IsHomotopyCategoryObject ],
    a -> ComputedHomologyAts( UnderlyingCell( a ) )
);

##
@InstallMethod( HomologyFunctorialAt,
          [ IsHomotopyCategoryMorphism, IsInt ],
    ( alpha, i ) -> HomologyFunctorialAt( UnderlyingCell( alpha ), i )
);

##
@InstallMethod( ComputedHomologyFunctorialAts,
          [ IsHomotopyCategoryMorphism ],
    a -> ComputedHomologyFunctorialAts( UnderlyingCell( a ) )
);

##
@InstallMethod( ObjectAt,
          [ IsHomotopyCategoryObject, IsInt ],
          
    (a, n) -> ObjectAt( UnderlyingCell( a ), n )
);

##
@InstallMethod( DifferentialAt,
          [ IsHomotopyCategoryObject, IsInt ],
          
    (a, n) -> DifferentialAt( UnderlyingCell( a ), n )
);

##
@InstallMethod( MorphismAt,
          [ IsHomotopyCategoryObject, IsInt ],
          
    (a, n) -> MorphismAt( UnderlyingCell( a ), n )
);


##
@InstallMethod( ObjectsSupport,
          [ IsHomotopyCategoryObject ],
    a -> ObjectsSupport( UnderlyingCell( a ) )
);

##
@InstallMethod( MorphismsSupport,
          [ IsHomotopyCategoryMorphism ],
    alpha -> MorphismsSupport( UnderlyingCell( alpha ) )
);

##
@InstallMethod( DifferentialsSupport,
          [ IsHomotopyCategoryObject ],
  a -> DifferentialsSupport( UnderlyingCell( a ) ));

##
@InstallMethod( HomologySupport,
          [ IsHomotopyCategoryObject ],
    a -> HomologySupport( UnderlyingCell( a ) )
);

##
@InstallMethod( CohomologySupport,
          [ IsHomotopyCategoryObject ],
    a -> CohomologySupport( UnderlyingCell( a ) )
);


##
@InstallMethod( ActiveLowerBound,
          [ IsHomotopyCategoryCell ],
    a -> ActiveLowerBound( UnderlyingCell( a ) )
);

##
@InstallMethod( ActiveUpperBound,
          [ IsHomotopyCategoryCell ],
    a -> ActiveUpperBound( UnderlyingCell( a ) )
);

##
@InstallMethod( SetLowerBound,
          [ IsHomotopyCategoryCell, IsInt ],
  function( a, n )
    
    SetLowerBound( UnderlyingCell( a ), n );
    
end );

##
@InstallMethod( SetUpperBound,
          [ IsHomotopyCategoryCell, IsInt ],
  function( a, n )
    
    SetUpperBound( UnderlyingCell( a ), n );
    
end );

##
@InstallMethod( HasActiveLowerBound,
          [ IsHomotopyCategoryCell ],
    a -> HasActiveLowerBound( UnderlyingCell( a ) )
);

##
@InstallMethod( HasActiveUpperBound,
          [ IsHomotopyCategoryCell ],
    a -> HasActiveUpperBound( UnderlyingCell( a ) )
);

##
@InstallMethod( ActiveLowerBoundForSourceAndRange,
          [ IsHomotopyCategoryMorphism ],
    alpha -> ActiveLowerBoundForSourceAndRange( UnderlyingCell( alpha ) )
);

##
@InstallMethod( Objects,
              [ IsHomotopyCategoryObject ],
  a -> Objects( UnderlyingCell( a ) )
);

##
@InstallMethod( Differentials,
              [ IsHomotopyCategoryObject ],
  a -> Differentials( UnderlyingCell( a ) )
);

##
@InstallMethod( Morphisms,
              [ IsHomotopyCategoryMorphism ],
  alpha -> Morphisms( UnderlyingCell( alpha ) )
);

##
@InstallMethod( *,
              [ IsRingElement, IsHomotopyCategoryObject ],
  ( r, a ) -> ( r * UnderlyingCell( a ) ) / CapCategory( a )
);

##
@InstallMethod( BrutalTruncationAbove,
              [ IsHomotopyCategoryCell, IsInt ],
  ( c, n ) -> BrutalTruncationAbove( UnderlyingCell( c ), n ) / CapCategory( c )
);

##
@InstallMethod( BrutalTruncationBelow,
              [ IsHomotopyCategoryCell, IsInt ],
  ( c, n ) -> BrutalTruncationBelow( UnderlyingCell( c ), n ) / CapCategory( c )
);

##
@InstallMethod( LaTeXOutput,
          [ IsHomotopyCategoryCell ],
  c -> LaTeXOutput( UnderlyingCell( c ) )
);

##
@InstallMethod( LaTeXOutput,
          [ IsHomotopyCategoryCell, IsInt, IsInt ],
  ( c, l, u ) -> LaTeXOutput( UnderlyingCell( c, l, u ) )
);

##
@InstallMethod( LaTeXOutput,
          [ IsHomotopyCategoryCell ],
  c -> LaTeXOutput( UnderlyingCell( c ) )
);

##
@InstallMethod( LaTeXOutput,
          [ IsHomotopyCategoryCell, IsInt, IsInt ],
  ( c, l, u ) -> LaTeXOutput( UnderlyingCell( c ), l, u )
);

