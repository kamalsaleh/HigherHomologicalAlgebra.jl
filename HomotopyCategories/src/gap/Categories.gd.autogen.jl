# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Declarations
#
#

@DeclareFilter( "IsHomotopyCategory", IsQuotientCategory );

@DeclareFilter( "IsHomotopyCategoryByCochains", IsHomotopyCategory );
@DeclareFilter( "IsHomotopyCategoryByChains", IsHomotopyCategory );


@DeclareAttribute( "HomotopyCategoryByCochains", IsCapCategory );
@DeclareAttribute( "HomotopyCategoryByChains", IsCapCategory );

@DeclareAttribute( "DefiningCategory", IsHomotopyCategory );
