# SPDX-License-Identifier: GPL-2.0-or-later
# Bicomplexes: Bicomplexes for Abelian categories
#
# Implementations
#

##
@InstallMethod( CreateBicomplexMorphism,
          [ IsBicomplexesCategory, IsChainOrCochainBicomplex, IsFunction, IsChainOrCochainBicomplex ],
  
  MorphismConstructor );

##
@InstallMethod( CreateBicomplexMorphism,
          [ IsChainOrCochainBicomplex, IsFunction, IsChainOrCochainBicomplex ],
  
  MorphismConstructor );

##
@InstallMethod( CreateBicomplexMorphism,
          [ IsBicomplexesCategory, IsChainOrCochainBicomplex, IsChainOrCochainMorphism, IsChainOrCochainBicomplex ],
  
  ( bicomplexes_cat, source, m, range ) -> ReinterpretationOfMorphism( bicomplexes_cat, source, m, range )
);

##
@InstallMethod( CreateBicomplexMorphism,
          [ IsBicomplexesCategory, IsChainOrCochainMorphism ],
  
  ( bicomplexes_cat, m ) -> ReinterpretationOfMorphism( bicomplexes_cat,
                                CreateBicomplex( bicomplexes_cat, Source( m ) ),
                                m,
                                CreateBicomplex( bicomplexes_cat, Range( m ) ) )
);

##
@InstallMethod( CreateBicomplexMorphism,
          [ IsBicomplexesCategory, IsChainOrCochainBicomplexMorphism ],
  
  ( bicomplexes_cat, m ) -> MorphismConstructor( bicomplexes_cat,
                                  CreateBicomplex( bicomplexes_cat, Source( m ) ),
                                  (i,j) -> MorphismFunction( m )( -i, -j ),
                                  CreateBicomplex( bicomplexes_cat, Range( m ) ) )
);

##
@InstallMethod( MorphismAt,
          [ IsChainOrCochainBicomplexMorphism, IsInt, IsInt ],
  
  ( mor, i, j ) -> MorphismFunction( mor )( i, j )
);

##
@InstallMethod( ViewString,
          [ IsChainOrCochainBicomplexMorphism ],
    
    _bicomplexes_ViewString
);

##
@InstallMethod( DisplayString,
          [ IsChainOrCochainBicomplexMorphism ],
  
  function ( mor )
    local b, str, b1, b2, b3, b4, i, j;
    
    b = [ Minimum( LeftBound( Source( mor ) ), LeftBound( Range( mor ) )  ),
           Maximum( RightBound( Source( mor ) ), RightBound( Range( mor ) ) ),
           Minimum( BelowBound( Source( mor ) ), BelowBound( Range( mor ) ) ),
           Maximum( AboveBound( Source( mor ) ), AboveBound( Range( mor ) ) ) ];

    str = "";
    
    # simplifies transpilation to julia
    b1 = b[1];
    b2 = b[2];
    b3 = b[3];
    b4 = b[4];

    for i in (b1):(b2)
      for j in (b3):(b4)
        
        str = @Concatenation( str, "\n-------------------------------------------\n" );
        str = @Concatenation( str, "At Indices ", StringGAP( [ i, j ] ), ":" );
        str = @Concatenation( str, "\n-------------------------------------------\n" );
        
        str = @Concatenation( str, "\nMorphism:\n" );
        str = @Concatenation( str, DisplayString( MorphismFunction( mor )(i, j) ) );
        
      end;
    end;
    
    str = @Concatenation( str, "\nAn object in ", Name( CapCategory( mor ) ), " defined by the above data\n" );
    
end );

