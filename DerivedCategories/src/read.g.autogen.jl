# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Reading the implementation part of the package.
#
include( "gap/DerivedCategories.gi.autogen.jl" );
include( "gap/Objects.gi.autogen.jl" );
include( "gap/Morphisms.gi.autogen.jl" );
include( "gap/Functors.gi.autogen.jl" );

#= comment for Julia
if IsPackageMarkedForLoading( "FunctorCategories", ">= 2022.09.23" ) then
# =#

include( "gap/OnlyWithFunctorCategories.gi.autogen.jl" );

#= comment for Julia
fi;
# =#
