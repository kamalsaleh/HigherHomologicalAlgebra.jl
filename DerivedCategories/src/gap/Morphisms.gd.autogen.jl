# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Declarations
#


@DeclareFilter( "IsDerivedCategoryMorphism", IsCapCategoryMorphism );

@DeclareFilter( "IsDerivedCategoryByCochainsMorphism", IsDerivedCategoryMorphism );
@DeclareFilter( "IsDerivedCategoryByChainsMorphism", IsDerivedCategoryMorphism );

@DeclareAttribute( "DefiningPairOfMorphisms", IsCapCategoryMorphism );
