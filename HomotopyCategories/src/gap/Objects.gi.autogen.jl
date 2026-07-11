# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#
#####################################################################


##
@InstallMethod( CreateComplex,
          [ IsHomotopyCategory, IsChainOrCochainComplex ],
  
  ObjectConstructor
);

##
@InstallMethod( CreateComplex,
          [ IsHomotopyCategory, IsList ],
  
  ( homotopy_cat, datum ) -> CallFuncListAtRuntime( ObjectConstructor, [ homotopy_cat, CallFuncListAtRuntime( CreateComplex, [ AmbientCategory( homotopy_cat ), datum ] ) ] )
);

##
@InstallMethod( CreateComplex,
          [ IsHomotopyCategory, IsCapCategoryObject, IsInt ],
  
  ( homotopy_cat, o, i ) -> ObjectConstructor( homotopy_cat, CreateComplex( AmbientCategory( homotopy_cat ), o, i ) )
);

##
@InstallMethod( CreateComplex,
          [ IsHomotopyCategory, IsDenseList, IsInt ],
  
  ( homotopy_cat, diffs, l ) -> ObjectConstructor( homotopy_cat, CreateComplex( AmbientCategory( homotopy_cat ), diffs, l ) )
);

##
@InstallMethod( /,
          [ IsChainOrCochainComplex, IsHomotopyCategory ],
  ( C, homotopy_cat ) -> ObjectConstructor( homotopy_cat, C )
);

##
@InstallMethod( getindex,
          [ IsHomotopyCategoryObject, IsInt ],

ObjectAt );

##
@InstallMethod( ^,
          [ IsHomotopyCategoryObject, IsInt ],

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
            return [ IsHomotopyCategoryObject ];
          elseif (info[2] == 2)
            return [ IsHomotopyCategoryObject, IsInt ];
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
                                        return "UnderlyingCell( C )";
                                      elseif (info[2] == 2)
                                        return "UnderlyingCell( C ), i";
                                      end;
                                    end)()))));
  
end;

##
@InstallMethod( ProjectiveResolution,
              [ IsHomotopyCategoryObject, IsBool ],
  
  ( C, bool ) -> CreateComplex( CapCategory( C ), ProjectiveResolution( UnderlyingCell( C ), bool ) )
);

##
@InstallMethod( QuasiIsomorphismFromProjectiveResolution,
              [ IsHomotopyCategoryObject, IsBool ],
  
  function( C, bool )
    local qC, S;
    
    qC = QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( C ), bool );
    
    S = ObjectConstructor( CapCategory( C ), Source( qC ) );
    
    return MorphismConstructor( CapCategory( C ), S, qC, C );
    
end );

##
@InstallMethod( InjectiveResolution,
              [ IsHomotopyCategoryObject, IsBool ],
  
  ( C, bool ) -> CreateComplex( CapCategory( C ), InjectiveResolution( UnderlyingCell( C ), bool ) )
);

##
@InstallMethod( QuasiIsomorphismIntoInjectiveResolution,
              [ IsHomotopyCategoryObject, IsBool ],
  
  function( C, bool )
    local qC, R;
    
    qC = QuasiIsomorphismIntoInjectiveResolution( UnderlyingCell( C ), bool );
    
    R = ObjectConstructor( CapCategory( C ), Range( qC ) );
    
    return MorphismConstructor( CapCategory( C ), C, qC, R );
    
end );

##
@InstallMethod( ApplyShiftOp,
          [ IsHomotopyCategoryObject, IsInt ],
  
  ( C, i ) -> CreateComplex( CapCategory( C ), [ ApplyShift( Objects( C ), i ), ApplyShift( ApplyMap( Differentials( C ), m -> (-1)^i * m ), i ),  LowerBound( C ) - i, UpperBound( C ) - i ] )
);

##
@InstallMethod( ApplyUnsignedShiftOp,
          [ IsHomotopyCategoryObject, IsInt ],
  
  ( C, i ) -> CreateComplex( CapCategory( C ), [ ApplyShift( Objects( C ), i ), ApplyShift( Differentials( C ), i ),  LowerBound( C ) - i, UpperBound( C ) - i ] )
);

##
@InstallMethod( ViewString,
        [ IsHomotopyCategoryObject ],

_complexes_ViewString );

##
@InstallMethod( DisplayString,
        [ IsHomotopyCategoryObject ],
  
  function ( C )
    local l, u;
    
    l = LowerBound( C );
    u = UpperBound( C );
    
    if (ForAll( [ l, u ], IsInt ))
        return @Concatenation( DisplayString( UnderlyingCell( C ), l, u ), "\nAn object in ", Name( CapCategory( C ) ), " defined by the above data\n" );
    else
        TryNextMethod( );
    end;
    
end );

