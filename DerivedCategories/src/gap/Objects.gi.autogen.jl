# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
@InstallMethod( CreateComplex,
          [ IsDerivedCategory, IsHomotopyCategoryObject ],
  
  ObjectConstructor
);

##
@InstallMethod( /,
          [ IsHomotopyCategoryObject, IsDerivedCategory ],
  
  ( C, derived_cat ) -> ObjectConstructor( derived_cat, C )
);

##
@InstallMethod( getindex,
          [ IsDerivedCategoryObject, IsInt ],

ObjectAt );

##
@InstallMethod( ^,
          [ IsDerivedCategoryObject, IsInt ],

DifferentialAt );

##
for info in [ [ "Objects", 1 ],
              [ "ObjectAt", 2 ],
              [ "ObjectsSupport", 1 ],
              [ "Differentials", 1 ],
              [ "DifferentialAt", 2 ],
              [ "DifferentialsSupport", 1 ],
              [ "LowerBound", 1 ],
              [ "UpperBound", 1 ],
              [ "CohomologyAt", 2 ],
              [ "CohomologySupport", 1 ],
              [ "HomologyAt", 2 ],
              [ "HomologySupport", 1 ],
              [ "CoboundariesAt", 2 ],
              [ "CoboundariesEmbeddingAt", 2 ],
              [ "BoundariesAt", 2 ],
              [ "BoundariesEmbeddingAt", 2 ],
              [ "CocyclesEmbeddingAt", 2 ],
              [ "CocyclesAt", 2 ],
              [ "CyclesEmbeddingAt", 2 ],
              [ "CyclesAt", 2 ],
              ]
  
  ##
  InstallOtherMethod(
      ValueGlobal( info[1] ),
      (function()
          if (info[2] == 1)
            return [ IsDerivedCategoryObject ];
          elseif (info[2] == 2)
            return [ IsDerivedCategoryObject, IsInt ];
          end;
      end)(),
      EvalString( ReplacedStringViaRecord( "i_args -> oper( s_args );",
                    @rec( oper = info[1],
                         i_args = (function()
                                      if (info[2] == 1)
                                        return "C";
                                      elseif (info[2] == 2)
                                        return "[ C, i ]";
                                      end;
                                    end)(),
                         s_args = (function()
                                      if (info[2] == 1)
                                        return "UnderlyingCell( UnderlyingCell( C ) )";
                                      elseif (info[2] == 2)
                                        return "UnderlyingCell( UnderlyingCell( C ) ), i";
                                      end;
                                    end)()))));
  
end;


##
@InstallMethod( Shift,
              [ IsDerivedCategoryObject, IsInt ],
  
  ( a, i ) -> CreateComplex( CapCategory( a ), Shift( UnderlyingCell( a ), i ) )
);

##
@InstallMethod( LaTeXOutput,
              [ IsDerivedCategoryObject ],
  a -> LaTeXOutput( UnderlyingCell( a ) )
);

##
@InstallMethod( ViewString,
        [ IsDerivedCategoryObject ],

_complexes_ViewString );

##
@InstallMethod( DisplayString,
        [ IsDerivedCategoryObject ],
  
  function ( C )
    local l, u;
    
    l = LowerBound( UnderlyingCell( C ) );
    u = UpperBound( UnderlyingCell( C ) );
    
    if (ForAll( [ l, u ], IsInt ))
        return @Concatenation( DisplayString( UnderlyingCell( UnderlyingCell( C ) ), l, u ), "\nAn object in ", Name( CapCategory( C ) ), " defined by the above data\n" );
    else
        TryNextMethod( );
    end;
    
end );

