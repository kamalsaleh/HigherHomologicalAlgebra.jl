# SPDX-License-Identifier: GPL-2.0-or-later
# Bicomplexes: Bicomplexes for Abelian categories
#
# Declarations
#
#
#! @Chapter Constructors
##
#############################################################################

#= comment for Julia
InfoBicomplexesCategories = NewInfoClass( "InfoBicomplexesCategories" );

SetInfoLevel( InfoBicomplexesCategories, 1 );
# =#

#! @Section Constructing categories

###################################################
#
# (Co)chain complexes categories filters
#
###################################################

#! @Description
#!  GAP-categories of the chain or cochain complexes category.
#! @Arguments C
@DeclareFilter( "IsBicomplexesCategory", IsCapCategory );

#! @Description
#!  GAP-categories of the chain complexes category.
#! @Arguments C
@DeclareFilter( "IsBicomplexesCategoryByCochains", IsBicomplexesCategory );

#! @Description
#!  GAP-category of the cochain complexes category.
#! @Arguments C
@DeclareFilter( "IsBicomplexesCategoryByChains", IsBicomplexesCategory );

@DeclareAttribute( "BicomplexesCategoryByCochains", IsCapCategory );
@DeclareAttribute( "BicomplexesCategoryByChains", IsCapCategory );


