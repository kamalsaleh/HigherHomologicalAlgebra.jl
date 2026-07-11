# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Reading the declaration part of the package.
#

include( "gap/DerivedCategories.gd.autogen.jl" );
include( "gap/Objects.gd.autogen.jl" );
include( "gap/Morphisms.gd.autogen.jl" );
include( "gap/Functors.gd.autogen.jl" );

#= comment for Julia
if IsPackageMarkedForLoading( "FunctorCategories", ">= 2022.09.23" ) then
# =#

include( "gap/OnlyWithFunctorCategories.gd.autogen.jl" );

#= comment for Julia
fi;
# =#

