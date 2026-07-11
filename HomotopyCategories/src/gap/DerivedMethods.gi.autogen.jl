# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
##
@InstallMethod( MorphismToColiftingObject,
          [ IsComplexesCategory, IsChainOrCochainComplex ],
          
  function( cat, a )
    
    return NaturalInjectionInMappingCone( IdentityMorphism( a ) );
    
end );

##
@InstallMethod( IsColiftableAlongMorphismToColiftingObject,
          [ IsComplexesCategory, IsChainOrCochainMorphism ],
          
  function( cat, alpha )
    local a, I_a;
    
    a = Source( alpha );
    
    I_a = NaturalInjectionInMappingCone( IdentityMorphism( a ) );
    
    return IsColiftable( I_a, alpha );
    
end );

##
@InstallMethod( IsColiftableAlongMorphismToColiftingObject,
          [ IsComplexesCategory, IsChainOrCochainMorphism ],
          
  ( cat, alpha ) -> IsNullHomotopic( alpha )
);

