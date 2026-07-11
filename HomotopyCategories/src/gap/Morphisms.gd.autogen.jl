# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Declarations
#
#
#####################################################################

@DeclareFilter( "IsHomotopyCategoryMorphism", IsQuotientCategoryMorphism );

@DeclareFilter( "IsHomotopyCategoryByCochainsMorphism", IsHomotopyCategoryMorphism );
@DeclareFilter( "IsHomotopyCategoryByChainsMorphism", IsHomotopyCategoryMorphism );

#= comment for Julia
@DeclareOperation( "\[\]",
            [ IsHomotopyCategoryMorphism, IsInt ] );
# =#

@KeyDependentOperation( "ApplyShift", IsHomotopyCategoryMorphism, IsInt, ReturnTrue );
@KeyDependentOperation( "ApplyUnsignedShift", IsHomotopyCategoryMorphism, IsInt, ReturnTrue );

