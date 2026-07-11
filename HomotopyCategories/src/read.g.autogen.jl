# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Reading the implementation part of the package.
#

include( "gap/Categories.gi.autogen.jl" );
include( "gap/Objects.gi.autogen.jl" );
include( "gap/Morphisms.gi.autogen.jl" );
include( "gap/HomStructure.gi.autogen.jl" );
include( "gap/TriangulatedStructure.gi.autogen.jl" );
include( "gap/Convolution.gi.autogen.jl" );
include( "gap/StrongExceptionalSequences.gi.autogen.jl" );
include( "gap/Functors.gi.autogen.jl" );
include( "gap/NaturalTransformations.gi.autogen.jl" );
include( "gap/OnlyWithAlgebroids.gi.autogen.jl" );

#= comment for Julia
if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    include( "gap/Julia.gi.autogen.jl" );
fi;
# =#
