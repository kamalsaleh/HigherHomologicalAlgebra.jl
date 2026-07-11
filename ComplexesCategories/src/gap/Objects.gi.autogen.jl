# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#



###########################################
#
# Constructors of (Co)chain complexes
#
###########################################

##
@InstallMethod( CreateComplex,
        [ IsComplexesCategory, IsList ],
  
  function( ch_cat, datum )
    
    if (!( Length( datum ) == 4 && IsZFunction( datum[1] ) && IsZFunction( datum[2] ) ))
      Error( "the list passed to 'CreateComplex' in ", "\033[34m", Name( ch_cat ), "\033[0m", " must have 4 entries and the first two entries are IsZFunction's!\n" );
    end;
    
    return CallFuncListAtRuntime( ObjectConstructor, [ ch_cat, datum ] );
    
end );

## Convenience methods
@InstallMethod( CreateComplex,
        [ IsComplexesCategory, IsZFunction, IsZFunction, IsObject, IsObject ],
  
  ( ch_cat, objs, diffs, lower_bound, upper_bound ) -> CreateComplex( ch_cat, [ objs, diffs, lower_bound, upper_bound ] )
);

@InstallMethod( CreateComplex,
        [ IsComplexesCategory, IsFunction, IsFunction, IsObject, IsObject ],
  
  ( ch_cat, objs, diffs, lower_bound, upper_bound ) -> CreateComplex( ch_cat, [ AsZFunction( objs ), AsZFunction( diffs ), lower_bound, upper_bound ] )
);

##
@InstallMethod( CreateComplex,
        [ IsComplexesCategory, IsZFunction, IsObject, IsObject ],
  
  ( ch_cat, diffs, lower_bound, upper_bound ) -> CreateComplex( ch_cat, ApplyMap( diffs, Source ), diffs, lower_bound, upper_bound )
);

##
@InstallMethod( CreateComplex,
        [ IsComplexesCategory, IsFunction, IsObject, IsObject ],
  
  ( ch_cat, diffs, lower_bound, upper_bound ) -> CreateComplex( ch_cat, AsZFunction( diffs ), lower_bound, upper_bound )
);

##
@InstallMethod( CreateComplex,
        [ IsComplexesCategory, IsZFunction ],
  
  ( ch_cat, diffs ) -> CreateComplex(  ch_cat, diffs, -infinity, infinity )
);

##
@InstallMethod( CreateComplex,
        [ IsComplexesCategory, IsFunction ],
  
  ( ch_cat, diffs ) -> CreateComplex(  ch_cat, AsZFunction( diffs ) )
);

##
@InstallMethod( CreateComplex,
        [ IsComplexesCategoryByCochains, IsDenseList, IsInt ],
        
  function( ch_cat, diffs_list, lower_bound )
    local underlying_cat, zero_obj, upper_bound, diffs;
    
    underlying_cat = UnderlyingCategory( ch_cat );
    
    if (ForAny( diffs_list, delta -> @not IsIdenticalObj( CapCategory( delta ), underlying_cat ) ))
        Error( "all morphisms in the list passed to 'CreateComplex' must belong to the category ", Name( underlying_cat ) );
    end;
    
    zero_obj = ZeroObject( UnderlyingCategory( ch_cat ) );
    
    upper_bound = lower_bound + Length( diffs_list );
    
    diffs =
      function( i )
        
        if (i == lower_bound - 1)
          return UniversalMorphismFromZeroObject( Source( diffs_list[ 1 ] ) );
        elseif (i >= lower_bound && i <= upper_bound - 1)
          return diffs_list[ i - lower_bound + 1 ];
        elseif (i == upper_bound)
          return UniversalMorphismIntoZeroObject( Range( diffs_list[ Length( diffs_list ) ] ) );
        else
          return ZeroObjectFunctorial( UnderlyingCategory( ch_cat ) );
        end;
        
      end;
    
    return CreateComplex( ch_cat, diffs, lower_bound, upper_bound );
    
end );

##
@InstallMethod( CreateComplex,
        [ IsComplexesCategoryByChains, IsDenseList, IsInt ],
        
  function( ch_cat, diffs_list, homological_index )
    local underlying_cat, zero_obj, upper_bound, diffs;
    
    underlying_cat = UnderlyingCategory( ch_cat );
    
    if (ForAny( diffs_list, delta -> @not IsIdenticalObj( CapCategory( delta ), underlying_cat ) ))
        Error( "all morphisms in the list passed to 'CreateComplex' must belong to the category ", Name( underlying_cat ) );
    end;
    
    zero_obj = ZeroObject( UnderlyingCategory( ch_cat ) );
    
    upper_bound = homological_index + Length( diffs_list ) - 1;
    
    diffs =
      function( i )
        
        if (i == homological_index - 1)
          return UniversalMorphismIntoZeroObject( Range( diffs_list[1] ) );
        elseif (i >= homological_index && i <= upper_bound)
          return diffs_list[i - homological_index + 1];
        elseif (i == upper_bound + 1)
          return UniversalMorphismFromZeroObject( Source( diffs_list[ Length( diffs_list ) ] ) );
        else
          return ZeroObjectFunctorial( UnderlyingCategory( ch_cat ) );
        end;
        
      end;
    
    return CreateComplex( ch_cat, diffs, homological_index - 1, upper_bound );
    
end );

##
@InstallMethod( CreateComplex,
      [ IsComplexesCategory, IsCapCategoryObject, IsInt ],
  
  function ( ch_cat, o, i )
    local cat, C;
    
    cat = UnderlyingCategory( ch_cat );
    
    if (@not IsIdenticalObj( cat, CapCategory( o ) ))
        Error( "the object passed in 'CreateComplex' does not belong to the underlying category of !\n", Name( ch_cat ) );
    end;
    
    C = CreateComplex( ch_cat, [ UniversalMorphismIntoZeroObject( cat, o ) ], i );
    
    return CreateComplex( ch_cat, [ Objects( C ), Differentials( C ), i, i ] );
    
end );

##
@InstallMethod( /,
      [ IsCapCategoryObject, IsComplexesCategory ],
  
  function ( o, ch_cat )
    
    if (@not IsIdenticalObj( CapCategory( o ), UnderlyingCategory( ch_cat ) ))
        TryNextMethod();
    end;
    
    return CreateComplex( ch_cat, o, 0 );
    
end );

#########################################
#
# Attributes of a (co)chain complexes
#
#########################################

##
@InstallMethod( DifferentialAtOp,
               [ IsChainOrCochainComplex, IsInt ],
  
  ( C, i ) -> Differentials( C )[ i ]
);

##
@InstallMethod( ^,
          [ IsChainOrCochainComplex, IsInt],
  
  DifferentialAt
);

##
@InstallMethod( ObjectAtOp,
               [ IsChainOrCochainComplex, IsInt ],
  
  ( C, i ) -> Objects( C )[ i ]
);

##
@InstallMethod( getindex,
          [ IsChainOrCochainComplex, IsInt ],
  
  ObjectAt
);

##
@InstallMethod( ObjectsSupport,
          [ IsChainOrCochainComplex, IsInt, IsInt ],
  
  ( C, m, n ) -> Filtered( (m):(n), i -> @not IsZeroForObjects( C[i] ) )
);

##
@InstallMethod( ObjectsSupport,
          [ IsChainOrCochainComplex ],
  
  C -> ObjectsSupport( C, LowerBound( C ), UpperBound( C ) )
);

##
@InstallMethod( DifferentialsSupport,
          [ IsChainOrCochainComplex, IsInt, IsInt ],
  
  ( C, m, n ) -> Filtered( (m):(n), i -> @not IsZeroForMorphisms( C^i ) )
);

##
@InstallMethod( DifferentialsSupport,
          [ IsChainOrCochainComplex ],
  
  C -> DifferentialsSupport( C, LowerBound( C ), UpperBound( C ) )
);

##
@InstallMethod( CocyclesAtOp,
          [ IsCochainComplex, IsInt ],
  
  ( C, i ) -> KernelObject( C^i )
);

##
@InstallMethod( CocyclesEmbeddingAtOp,
          [ IsCochainComplex, IsInt ],
  
  ( C, i ) -> KernelEmbeddingWithGivenKernelObject( C^i, CocyclesAt( C, i ) )
);

##
@InstallMethod( CoboundariesAtOp,
          [ IsCochainComplex, IsInt ],
  
  ( C, i ) -> ImageObject( DifferentialAt( C, i - 1 ) )
);

##
@InstallMethod( CoboundariesEmbeddingAtOp,
          [ IsCochainComplex, IsInt ],
  
  ( C, i ) -> ImageEmbeddingWithGivenImageObject( DifferentialAt( C, i - 1 ), CoboundariesAt( C, i ) )
);

##
@InstallMethod( CohomologyAtOp,
          [ IsCochainComplex, IsInt ],
  
  function ( C, i )
    local cat;
    
    cat = UnderlyingCategory( CapCategory( C ) );
    
    if (!( HasIsAbelianCategory( cat ) && IsAbelianCategory( cat ) ))
      
      Error( "(Co)homology is computable only in abelian categories!\n" );
      
    end;
    
    return CokernelObject( KernelLiftWithGivenKernelObject( C^i, CoboundariesEmbeddingAt( C, i ), CocyclesAt( C, i ) ) );
    
end );

##
@InstallMethod( CohomologySupport,
          [ IsCochainComplex, IsInt, IsInt ],
  
  ( C, m, n ) -> Filtered( (m):(n), i -> @not IsZeroForObjects( CohomologyAt( C, i ) ) )
);

##
@InstallMethod( CohomologySupport,
          [ IsCochainComplex ],
  
  C -> CohomologySupport( C, LowerBound( C ), UpperBound( C ) )
);

##
@InstallMethod( CyclesAtOp,
        [ IsChainComplex, IsInt ],
  
  ( C, i ) -> CocyclesAtOp( AsCochainComplex( C ), -i )
);

##
@InstallMethod( CyclesEmbeddingAtOp,
        [ IsChainComplex, IsInt ],
  
  ( C, i ) -> CocyclesEmbeddingAtOp( AsCochainComplex( C ), -i )
);

##
@InstallMethod( BoundariesAtOp,
        [ IsChainComplex, IsInt ],
  
  ( C, i ) -> CoboundariesAtOp( AsCochainComplex( C ), -i )
);

##
@InstallMethod( BoundariesEmbeddingAtOp,
        [ IsChainComplex, IsInt ],
  
  ( C, i ) -> CoboundariesEmbeddingAtOp( AsCochainComplex( C ), -i )
);

##
@InstallMethod( HomologyAtOp,
        [ IsChainComplex, IsInt ],
  
  ( C, i ) -> CohomologyAtOp( AsCochainComplex( C ), -i )
);

##
@InstallMethod( HomologySupport,
          [ IsChainComplex, IsInt, IsInt ],
  
  ( C, m, n ) -> -1 * Reversed( CohomologySupport( AsCochainComplex( C ), -n, -m ) )
);

##
@InstallMethod( HomologySupport,
          [ IsChainComplex ],
  
  C -> HomologySupport( C, LowerBound( C ), UpperBound( C ) )
);

##
@InstallMethod( IsExact,
          [ IsCochainComplex, IsInt, IsInt ],
  
  ( C, m, n ) -> IsEmpty( CohomologySupport( C, m, n ) )
);

##
@InstallMethod( IsExact,
          [ IsChainComplex, IsInt, IsInt ],

  ( C, m, n ) -> IsEmpty( HomologySupport( C, m, n ) )
);

##
@InstallMethod( IsExact,
          [ IsChainOrCochainComplex ],
  
  C -> IsExact( C, LowerBound( C ), UpperBound( C ) )
);

##
@InstallMethod( AsComplexOverOppositeCategory,
          [ IsCochainComplex ],
  
  function( C )
    local cat, cat_op, coch_cat_op, o, diff, B;
    
    cat = UnderlyingCategory( CapCategory( C ) );
    
    cat_op = Opposite( cat; only_primitive_operations_and_hom_structure = true );
    
    coch_cat_op = ComplexesCategoryByCochains( cat_op );
    
    o = i -> Opposite( Objects( C )[-i] );
    
    diff = i -> Opposite( Differentials( C )[-i-1] );
    
    B = CreateComplex( coch_cat_op, o, diff, -UpperBound( C ), -LowerBound( C ) );
    
    SetAsComplexOverOppositeCategory( B, C );
    
    return B;
    
end );

##
@InstallMethod( AsCochainComplex,
          [ IsChainComplex ],
  
  C -> ModelingTowerObjectConstructor( CapCategory( C ), ObjectDatum( C ) )
);

##
@InstallMethod( AsChainComplex,
          [ IsCochainComplex ],
  
  function( C )
    local ch_cat;
    
    ch_cat = ComplexesCategoryByChains( UnderlyingCategory( CapCategory( C ) ) );
    
    return ObjectConstructor( ch_cat, ModelingTowerObjectDatum( ch_cat, C ) );
    
end );

#########################################
#
# Displaying, viewing (co)chain complexes
#
#########################################

@BindGlobal( "_complexes_ViewString",
  
  function ( x )
    local l, u, cell, bounds_includes_infty;
    
    l = LowerBound( x );
    u = UpperBound( x );
    
    bounds_includes_infty = false;
    
    if (@not IsInt( l ))
      bounds_includes_infty = true;
      if (l == infinity)
        l = "+∞";
      elseif (l == -infinity)
        l = "-∞";
      end;
    end;
    
    if (@not IsInt( u ))
      bounds_includes_infty = true;
      if (u == infinity)
        u = "+∞";
      elseif (u == -infinity)
        u = "-∞";
      end;
    end;
    
    if (IsCapCategoryObject( x ))
        cell = "An object";
    elseif (IsCapCategoryMorphism( x ))
        cell = "A morphism";
    end;
    
    # we use " .", ". " instead of " .. " to avoid rewriting to ":" in Julia
    if (IsIdenticalObj( l, u ))
      return @Concatenation( "<", cell, " in ", Name( CapCategory( x ) ), " supported on the interval [ ", StringGAP( l ), " ]>" );
    else
      return @Concatenation( "<", cell, " in ", Name( CapCategory( x ) ), " supported on the interval [ ", StringGAP( l ), " .", ". ", StringGAP( u ), " ]>" );
    end;
    
end );

##
@InstallMethod( ViewString, [ IsChainOrCochainComplex ], _complexes_ViewString );

##
@InstallMethod( DisplayString,
        [ IsCochainComplex, IsInt, IsInt ],

  function ( C, l, u )
    local str, s, i;
    
    str = "";
    
    for i in Reversed( (l):(u) )
      if (i != u)
        str = @Concatenation( str, "   ", "⋏", "\n" );
        str = @Concatenation( str, "   |\n" );
        str = @Concatenation( str, DisplayString( C^i ) );
        str = @Concatenation( str, "   |\n\n" );
      end;
      s = @Concatenation( "== ", StringGAP( i ), " =======================" );
      str = @Concatenation( str, s, "\n" );
      str = @Concatenation( str, DisplayString( C[i] ) );
      str = @Concatenation( str,
        @Concatenation(
          ListWithIdenticalEntries(
            Length( s ), "=" ) ),
        "\n\n" );
    end;
    
    return str;
    
end );

##
@InstallMethod( DisplayString,
        [ IsChainComplex, IsInt, IsInt ],
  
  function ( C, l, u )
    local str, s, i;
    
    str = "";
    
    for i in Reversed( (l):(u) )
      
      s = @Concatenation( "== ", StringGAP( i ), " =======================" );
      str = @Concatenation( str, s, "\n" );
      str = @Concatenation( str, ViewString( C[i] ), "\n" );
      str = @Concatenation( str,
        @Concatenation(
          ListWithIdenticalEntries(
            Length( s ), "=" ) ),
        "\n\n" );
      if (i != l)
        str = @Concatenation( str, "   |\n" );
        str = @Concatenation( str, DisplayString( C^i ) );
        str = @Concatenation( str, "   |\n" );
        str = @Concatenation( str, "   ", "⋎", "\n\n" );
      end;
      
    end;
    
    return str;
    
end );

##
@InstallMethod( DisplayString,
        [ IsChainOrCochainComplex ],
        
  function ( C )
    local l, u;
    
    l = LowerBound( C );
    u = UpperBound( C );
    
    if (ForAll( [ l, u ], IsInt ))
        return @Concatenation( DisplayString( C, l, u ), "\nAn object in ", Name( CapCategory( C ) ), " defined by the above data\n" );
    else
        TryNextMethod();
    end;
    
end );

##
@InstallMethod( LaTeXOutput,
        [ IsCochainComplex, IsInt, IsInt ],
        
  function ( C, l, u )
    local latex_string, i;
    
    latex_string = @Concatenation( "\\begin", LATEX_LBRACE, "array", LATEX_RBRACE, LATEX_LBRACE, "c", LATEX_RBRACE, "\n" );
    latex_string = @Concatenation( latex_string, LaTeXOutput( C[ u ] ), "\n" );
    
    for i in Reversed( (l):(u - 1) )
      
      latex_string = @Concatenation( latex_string, "\\\\\n\\uparrow_", LATEX_LBRACE, "\\phantom", LATEX_LBRACE, StringGAP( i ), LATEX_RBRACE, LATEX_RBRACE, "\n\\\\\n" );
      latex_string = @Concatenation( latex_string, LaTeXOutput( C ^ i; OnlyDatum = true ), "\n\\\\\n" );
      latex_string = @Concatenation( latex_string, LATEX_LBRACE, "\\vert_", LATEX_LBRACE, StringGAP( i ), LATEX_RBRACE, LATEX_RBRACE, "\n" );
      latex_string = @Concatenation( latex_string, "\n\\\\\n", LaTeXOutput( C[ i ] ) );
      
    end;
    
    return @Concatenation( latex_string, "\\end", LATEX_LBRACE, "array", LATEX_RBRACE );
    
end );

#
@InstallMethod( LaTeXOutput,
        [ IsChainComplex, IsInt, IsInt ],
  function ( C, l, u )
    local latex_string, i;
    
    latex_string = @Concatenation( "\\begin", LATEX_LBRACE, "array", LATEX_RBRACE, LATEX_LBRACE, "c", LATEX_RBRACE, "\n " );
    
    for i in Reversed( (l + 1):(u) )
      
      latex_string = @Concatenation( latex_string, "\n", LaTeXOutput( C[ i ] ), "\n" );
      latex_string = @Concatenation( latex_string, "\\\\\n\\vert^", LATEX_LBRACE, StringGAP( i ), LATEX_RBRACE, "\n\\\\\n" );
      latex_string = @Concatenation( latex_string, LaTeXOutput( C ^ i; OnlyDatum = true ), "\n\\\\\n" );
      latex_string = @Concatenation( latex_string, LATEX_LBRACE, "\\downarrow_", LATEX_LBRACE, "\\phantom", LATEX_LBRACE, StringGAP( i ), LATEX_RBRACE, LATEX_RBRACE, LATEX_RBRACE, "\\\\\n" );
      
    end;
    
    latex_string = @Concatenation( latex_string, "\n", LaTeXOutput( C[ l ] ) );
    latex_string = @Concatenation( latex_string, "\\end", LATEX_LBRACE, "array", LATEX_RBRACE );
    
    return latex_string;
    
end );

##
@InstallMethod( LaTeXOutput,
          [ IsChainOrCochainComplex ],
  function ( C )
    local l, u;
    
    l = LowerBound( C );
    u = UpperBound( C );
    
    if (ForAll( [ l, u ], IsInt ))
        return LaTeXOutput( C, l, u );
    else
        return fail;
    end;
    
end );

