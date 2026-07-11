# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#

##
@BindGlobal( "_complexes_AsComplexOverFullSubcategory",
  
  function( subcat, C )
    local ch_cat, as_cell;
    
    if (IsCochainComplex( C ))
        ch_cat = ComplexesCategoryByCochains( subcat );
    else
        ch_cat = ComplexesCategoryByChains( subcat );
    end;
    
    as_cell = ValueGlobal( "AsSubcategoryCell" );
    
    return CreateComplex(
                  ch_cat,
                  ApplyMap( Objects( C ), o -> as_cell( subcat, o ) ),
                  ApplyMap( Differentials( C ), delta -> as_cell( subcat, delta ) ),
                  LowerBound( C ),
                  UpperBound( C ) );
    
end );

##
@BindGlobal( "_complexes_AsComplexMorphismOverFullSubcategory",
  
  function( s, phi, r )
    local subcat, as_cell;
    
    subcat = UnderlyingCategory( CapCategory( s ) );
    
    as_cell = ValueGlobal( "AsSubcategoryCell" );
    
    return CreateComplexMorphism(
                  s,
                  r,
                  ApplyMap( Morphisms( phi ), m -> as_cell( subcat, m ) ),
                  LowerBound( phi ),
                  UpperBound( phi ) );
    
end );

