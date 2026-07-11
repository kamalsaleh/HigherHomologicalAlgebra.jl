# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#

##
@InstallMethod( ShiftOfBackwardConvolution_into_BackwardConvolutionOfShiftOp,
          [ IsHomotopyCategoryObject, IsInt ],
          
  function( C, n )
    local diffs, D, z_func, alpha;
    
    if (n mod 2 == 0)
      
      return IdentityMorphism( Shift( BackwardConvolution( C ), n ) );
      
    end;
    
    diffs = Differentials( C );
    
    diffs = ApplyMap( diffs, AdditiveInverse );
    
    D = HomotopyCategoryObject( CapCategory( C ), diffs );
    
    SetLowerBound( D, ActiveLowerBound( C ) );
    
    SetUpperBound( D, ActiveUpperBound( C ) );
    
    z_func = AsZFunction( i -> ( -1 ) ^ i * IdentityMorphism( C[ i ] ) );
    
    alpha = HomotopyCategoryMorphism( C, D, z_func );
    
    return Shift( BackwardConvolution( alpha ), n );

end );

##
@InstallMethod( BackwardConvolutionOfShift_into_ShiftOfBackwardConvolutionOp,
          [ IsHomotopyCategoryObject, IsInt ],
  function( C, n )
    local m;
    
    m = ShiftOfBackwardConvolution_into_BackwardConvolutionOfShift( C, n );
    
    return HomotopyCategoryMorphism( Range( m ), Source( m ), Morphisms( m ) );
    
end );

#####################################
#
# For cochains categories cells
#
#####################################

##
@InstallMethod( BackwardPostnikovSystemAtOp,
          [ IsCochainComplex, IsInt ],
          
  function( C, m )
    local l, u, alpha, beta, H, maps, d, diffs;
    
    l = ActiveLowerBound( C );
    
    u = ActiveUpperBound( C );
    
    if (m + 1 > u)
      
      return C;
      
    elseif (m + 1 < u)
      
      return BackwardPostnikovSystemAt( BackwardPostnikovSystemAt( C, m + 1 ), m );
      
    elseif (u - l in [ 0, 1 ])
      
      return StalkCochainComplex( InverseShiftOnObject( StandardConeObject( C ^ m ) ), m );
      
    else
      
      alpha = C ^ ( m - 1 );
      
      beta = C ^ m;
      
      H = HomotopyMorphisms( AdditiveInverse( PreCompose( alpha, beta ) ) );
      
      if (H == fail)
        
        Error( "The input is not well-defined!" );
        
      end;
      
      maps = AsZFunction( i -> MorphismBetweenDirectSums( [ [ alpha[ i ], H[ i ] ] ] ) );
      
      d = HomotopyCategoryMorphism(
                  Source( alpha ),
                  InverseShiftOnObject( StandardConeObject( beta ) ),
                  maps
                );
                
      diffs = List( (l):(u - 3), i -> C ^ i );
      
      Add( diffs, d );
      
      return CochainComplex( diffs, l );
      
    end;
    
end );

##
@InstallMethod( BackwardConvolution,
          [ IsCochainComplex ],
          
  function( C )
    local ambient_cat, cat, l;
    
    ambient_cat = CapCategory( C );
    
    cat = UnderlyingCategory( ambient_cat );
    
    if (@not IsHomotopyCategory( cat ))
      
      TryNextMethod( );
      
    end;
    
    l = ActiveLowerBound( C );
    
    C = BackwardPostnikovSystemAt( C, l );
    
    return Shift( C[ l ], -l );
    
end );

##
@InstallMethod( BackwardConvolution,
            "for chain complexes over additive closures",
          [ IsCochainComplex ],
          
  function( C )
    local ambient_cat, cat, full, I;
    
    ambient_cat = CapCategory( C );
    
    cat = UnderlyingCategory( ambient_cat );
    
    if (@not IsAdditiveClosureCategory( cat ))
      
      TryNextMethod( );
      
    end;
    
    full = UnderlyingCategory( cat );
    
    I = ValueGlobal( "InclusionFunctor" )( full );
    
    I = ExtendFunctorToAdditiveClosureOfSource( I );
    
    I = ExtendFunctorToCochainComplexCategories( I );
    
    return BackwardConvolution( I( C ) );
    
end );

##
@InstallMethod( BackwardPostnikovSystemAtOp,
          [ IsCochainMorphism, IsInt ],
          
  function( alpha, m )
    local C, D, l, u, map, maps, s, r;
    
    l = ActiveLowerBoundForSourceAndRange( alpha );
    
    u = ActiveUpperBoundForSourceAndRange( alpha );
    
    if (m + 1 > u)
      
      return alpha;
      
    elseif (m + 1 < u)
      
      return BackwardPostnikovSystemAt( BackwardPostnikovSystemAt( alpha, m + 1 ), m );
      
    else
      
      map = MorphismBetweenStandardConeObjects(
                Source( alpha ) ^ m,
                alpha[ m ],
                alpha[ m + 1 ],
                Range( alpha ) ^ m
              );
              
      map = InverseShiftOnMorphism( map );
      
      if (u - l in [ 0, 1 ])
        
        return StalkCochainMorphism( map, m );
        
      else
        
        maps = List( (l):(u - 2), i -> alpha[ i ] );
        
        Add( maps, map );
        
        s = BackwardPostnikovSystemAt( Source( alpha ), m );
        
        r = BackwardPostnikovSystemAt( Range( alpha ), m );
        
        return CochainMorphism( s, r, maps, l );
        
      end;
      
    end;
    
end );

##
@InstallMethod( BackwardConvolution,
          [ IsCochainMorphism ],
          
  function( alpha )
    local ambient_cat, cat, l;
    
    ambient_cat = CapCategory( alpha );
    
    cat = UnderlyingCategory( ambient_cat );
    
    if (@not IsHomotopyCategory( cat ))
      
      TryNextMethod( );
      
    end;
   
    l = ActiveLowerBoundForSourceAndRange( alpha );
    
    alpha = BackwardPostnikovSystemAt( alpha, l );
    
    return Shift( alpha[ l ], -l );
    
end );

##
@InstallMethod( BackwardConvolution,
            "for cochain morphisms over additive closures",
          [ IsCochainMorphism ],
          
  function( alpha )
    local ambient_cat, cat, full, I;
    
    ambient_cat = CapCategory( alpha );
    
    cat = UnderlyingCategory( ambient_cat );
    
    if (@not IsAdditiveClosureCategory( cat ))
      
      TryNextMethod( );
      
    end;
    
    full = UnderlyingCategory( cat );
    
    I = ValueGlobal( "InclusionFunctor" )( full );
    
    I = ExtendFunctorToAdditiveClosureOfSource( I );
    
    I = ExtendFunctorToCochainComplexCategories( I );
    
    return BackwardConvolution( I( alpha ) );
    
end );

#####################################
#
# For homotopy category cells
#
#####################################

##
@InstallMethod( ForwardPostnikovSystemAt,
        [ IsHomotopyCategoryCell, IsInt ],
        
  ( c, m ) -> ForwardPostnikovSystemAt( UnderlyingCell( c ), m ) / CapCategory( c )
);

##
@InstallMethod( BackwardPostnikovSystemAt,
        [ IsHomotopyCategoryCell, IsInt ],
        
  ( c, m ) -> BackwardPostnikovSystemAt( UnderlyingCell( c ), m ) / CapCategory( c )
);

##
@InstallMethod( ForwardConvolution,
          [ IsHomotopyCategoryCell ],
          
  c -> ForwardConvolution( UnderlyingCell( c ) )
);

##
@InstallMethod( BackwardConvolution,
          [ IsHomotopyCategoryCell ],
          
  c -> BackwardConvolution( UnderlyingCell( c ) )
);

