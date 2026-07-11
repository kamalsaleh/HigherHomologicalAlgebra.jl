# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#####################################################################

##
@InstallMethod( CreateComplexMorphism,
      [ IsHomotopyCategory, IsHomotopyCategoryObject, IsChainOrCochainMorphism, IsHomotopyCategoryObject ],
  
  MorphismConstructor
);

##
@InstallMethod( CreateComplexMorphism,
      [ IsHomotopyCategory, IsHomotopyCategoryObject, IsZFunction, IsHomotopyCategoryObject ],
  
  ( homotopy_cat, S, morphisms, R ) -> MorphismConstructor(
                                            homotopy_cat,
                                            S,
                                            CreateComplexMorphism( AmbientCategory( homotopy_cat ), UnderlyingCell( S ), morphisms, UnderlyingCell( R ) ),
                                            R )
);

##
@InstallMethod( CreateComplexMorphism,
      [ IsHomotopyCategory, IsHomotopyCategoryObject, IsFunction, IsHomotopyCategoryObject ],
  
  ( homotopy_cat, S, morphisms, R ) -> CreateComplexMorphism( homotopy_cat, S, AsZFunction( morphisms ), R )
);

##
@InstallMethod( CreateComplexMorphism,
      [ IsHomotopyCategory, IsHomotopyCategoryObject, IsDenseList, IsInt, IsHomotopyCategoryObject ],
  
  ( homotopy_cat, S, morphisms, l, R ) -> MorphismConstructor(
                                                homotopy_cat,
                                                S,
                                                CreateComplexMorphism( AmbientCategory( homotopy_cat ), UnderlyingCell( S ), morphisms, l, UnderlyingCell( R ) ),
                                                R )
);

##
@InstallMethod( CreateComplexMorphism,
      [ IsHomotopyCategory, IsHomotopyCategoryObject, IsZFunction, IsInt, IsInt, IsHomotopyCategoryObject ],
  
  ( homotopy_cat, S, morphisms, l, u, R ) -> MorphismConstructor(
                                                homotopy_cat,
                                                S,
                                                CreateComplexMorphism( AmbientCategory( homotopy_cat ), UnderlyingCell( S ), morphisms, l, u, UnderlyingCell( R ) ),
                                                R )
);

##
@InstallMethod( CreateComplexMorphism,
      [ IsHomotopyCategory, IsChainOrCochainMorphism ],
  
  ( homotopy_cat, alpha ) -> MorphismConstructor( homotopy_cat, ObjectConstructor( homotopy_cat, Source( alpha ) ), alpha, ObjectConstructor( homotopy_cat, Range( alpha ) ) )
);

##
@InstallMethod( /,
      [ IsChainOrCochainMorphism, IsHomotopyCategory ],
  
  ( alpha, homotopy_cat ) -> CreateComplexMorphism( homotopy_cat, alpha )
);

##
for info in [ [ "Morphisms", 1 ],
              [ "MorphismAt", 2 ],
              [ "MorphismsSupport", 1 ],
              [ "LowerBound", 1 ],
              [ "UpperBound", 1 ],
              [ "CohomologyFunctorialAt", 2 ],
              [ "HomologyFunctorialAt", 2 ],
              [ "CocyclesFunctorialAt", 2 ],
              [ "CyclesFunctorialAt", 2 ],
              [ "WitnessForBeingHomotopicToZeroMorphism", 1 ],
              [ "IsQuasiIsomorphism", 1 ],
              ]
  
  ##
  InstallOtherMethod(
      ValueGlobal( info[1] ),
      (function()
          if (info[2] == 1)
            return [ IsHomotopyCategoryMorphism ];
          elseif (info[2] == 2)
            return [ IsHomotopyCategoryMorphism, IsInt ];
          end;
      end)(),
      EvalString( ReplacedStringViaRecord( "i_args -> oper( s_args );",
                    @rec( oper = info[1],
                         i_args = (function()
                                      if (info[2] == 1)
                                        return "phi";
                                      elseif (info[2] == 2)
                                        return "[ phi, i ]";
                                      end;
                                    end)(),
                         s_args = (function()
                                      if (info[2] == 1)
                                        return "UnderlyingCell( phi )";
                                      elseif (info[2] == 2)
                                        return "UnderlyingCell( phi ), i";
                                      end;
                                    end)()))));
  
end;


##
@InstallMethod( MorphismBetweenInjectiveResolutions,
              [ IsHomotopyCategoryMorphism, IsBool ],
  
  function( alpha, bool )
    local m, S, R;
    
    m = MorphismBetweenInjectiveResolutions( UnderlyingCell( alpha ), bool );
    
    S = ObjectConstructor( CapCategory( alpha ), Source( m ) );
    R = ObjectConstructor( CapCategory( alpha ), Range( m ) );
    
    return MorphismConstructor( CapCategory( alpha ), S, m, R );
end );

##
@InstallMethod( MorphismBetweenProjectiveResolutions,
              [ IsHomotopyCategoryMorphism, IsBool ],
  
  function( alpha, bool )
    local m, S, R;
    
    m = MorphismBetweenProjectiveResolutions( UnderlyingCell( alpha ), bool );
    
    S = ObjectConstructor( CapCategory( alpha ), Source( m ) );
    R = ObjectConstructor( CapCategory( alpha ), Range( m ) );
    
    return MorphismConstructor( CapCategory( alpha ), S, m, R );
end );

##
@InstallMethod( ApplyShiftOp,
          [ IsHomotopyCategoryMorphism, IsInt ],
  
  ( alpha, i ) -> CreateComplexMorphism(
                      CapCategory( alpha ),
                      ApplyShift( Source( alpha ), i ),
                      ApplyShift( Morphisms( alpha ), i ),
                      ApplyShift( Range( alpha ), i ) )
);

##
@InstallMethod( ApplyUnsignedShiftOp,
          [ IsHomotopyCategoryMorphism, IsInt ],
  
  ( alpha, i ) -> CreateComplexMorphism(
                      CapCategory( alpha ),
                      ApplyUnsignedShift( Source( alpha ), i ),
                      ApplyShift( Morphisms( alpha ), i ),
                      ApplyUnsignedShift( Range( alpha ), i ) )
);


##
@InstallMethod( getindex,
          [ IsHomotopyCategoryMorphism, IsInt ],
  
  ( phi, i ) -> UnderlyingCell( phi )[ i ]
);

##
@InstallMethod( ViewString, [ IsHomotopyCategoryMorphism ], _complexes_ViewString );

##
@InstallMethod( DisplayString,
        [ IsHomotopyCategoryMorphism ],
  
  function( phi )
    local l, u;
    
    l = LowerBound( phi );
    u = UpperBound( phi );
    
    if (ForAll( [ l, u ], IsInt ))
        return @Concatenation( DisplayString( UnderlyingCell( phi ), l, u ), "\nA morphism in ", Name( CapCategory( phi ) ), " defined by the above data\n" );
    else
        TryNextMethod( );
    end;
    
end );

