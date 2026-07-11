# SPDX-License-Identifier: GPL-2.0-or-later
# Bicomplexes: Bicomplexes for Abelian categories
#
# Implementations
#

##
@InstallMethod( CreateBicomplex,
          [ IsBicomplexesCategory, IsList ],

ObjectConstructor );

##
@InstallMethod( CreateBicomplex,
          [ IsBicomplexesCategory, IsChainOrCochainComplex ],
  
  ( bicomplexes_cat, o ) -> ReinterpretationOfObject( bicomplexes_cat, o )
);

##
@BindGlobal( "CREATE_BICOMPLEX_FROM_BICOMPLEX",
   
  ( bicomplexes_cat, o ) -> ObjectConstructor( bicomplexes_cat,
                                [ (i,j) -> ObjectFunction( o )( -i, -j ),
                                  (i,j) -> HorizontalDifferentialFunction( o )( -i, -j ),
                                  (i,j) -> VerticalDifferentialFunction( o )( -i, -j ),
                                  -RightBound( o ), -LeftBound( o ),
                                  -AboveBound( o ), -BelowBound( o ) ] )
);

##
@InstallMethod( CreateBicomplex,
          [ IsBicomplexesCategoryByCochains, IsChainBicomplex ],
  
  CREATE_BICOMPLEX_FROM_BICOMPLEX );

##
@InstallMethod( CreateBicomplex,
          [ IsBicomplexesCategoryByChains, IsCochainBicomplex ],
  
  CREATE_BICOMPLEX_FROM_BICOMPLEX );

##
@InstallMethod( ObjectAt,
               [ IsChainOrCochainBicomplex, IsInt, IsInt ],
  
  ( obj, i, j ) -> ModelingObject( CapCategory( obj ), obj )[i][j]
    # or ( obj, i, j ) -> ObjectFunction( obj )( i, j ) (not cached)
);

##
@InstallMethod( HorizontalDifferentialAt,
               [ IsChainOrCochainBicomplex, IsInt, IsInt ],
  
  ( obj, i, j ) -> (ModelingObject( CapCategory( obj ), obj )^i)[j]
  # or ( obj, i, j ) -> HorizontalDifferentialFunction( obj )( i, j ) (not cached)
);

##
@InstallMethod( VerticalDifferentialAt,
               [ IsChainOrCochainBicomplex, IsInt, IsInt ],
  
  ( obj, i, j ) -> (-1)^i * ModelingObject( CapCategory( obj ), obj )[i]^j
  # or ( obj, i, j ) -> VerticalDifferentialFunction( obj )( i, j ) (not cached)
);


##
@InstallMethod( ViewString,
          [ IsChainOrCochainBicomplex ],
    
    _bicomplexes_ViewString
);

##
@InstallMethod( DisplayString,
          [ IsChainOrCochainBicomplex ],
  
  function ( obj )
    local str, i, j;
    
    str = "";
    
    for i in (LeftBound( obj )):(RightBound( obj ))
      for j in (BelowBound( obj )):(AboveBound( obj ))
        
        str = @Concatenation( str, "\n-------------------------------------------\n" );
        str = @Concatenation( str, "At Indices ", StringGAP( [i, j] ), ":" );
        str = @Concatenation( str, "\n-------------------------------------------\n" );
        
        str = @Concatenation( str, "\nObject:\n" );
        str = @Concatenation( str, DisplayString( ObjectFunction( obj )(i, j) ) );
        
        str = @Concatenation( str, "\nHorizontal Differential:\n" );
        str = @Concatenation( str, DisplayString( HorizontalDifferentialFunction( obj )(i, j) ) );
        
        str = @Concatenation( str, "\nVertical Differential:\n" );
        str = @Concatenation( str, DisplayString( VerticalDifferentialFunction( obj )(i, j) ) );
        
      end;
    end;
    
    str = @Concatenation( str, "\nAn object in ", Name( CapCategory( obj ) ), " defined by the above data\n" );
    
    return str;
    
end );

