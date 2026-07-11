#!/bin/bash

set -e

# Check if token exists
if [ -z "$JULIA_SUBSPLIT_TOKEN" ]; then
  echo -e "\033[31mERROR: Missing JULIA_SUBSPLIT_TOKEN\033[0m"
  exit 1
fi

# update git index
git status > /dev/null

if ! git diff-index --quiet HEAD; then
	echo -e "\033[33mWARNING: Dirty working tree.\033[0m"
fi

if [[ "$(git rev-parse --abbrev-ref HEAD)" != "master" ]]; then
	echo -e "\033[31mERROR: Not on branch master\033[0m"
	exit 1
fi

# TriangulatedCategories
git subtree split --prefix=TriangulatedCategories -b TriangulatedCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/TriangulatedCategories.jl.git TriangulatedCategories-split:master
echo "Pushed to TriangulatedCategories.jl"

# ComplexesCategories
git subtree split --prefix=ComplexesCategories -b ComplexesCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/ComplexesCategories.jl.git ComplexesCategories-split:master
echo "Pushed to ComplexesCategories.jl"

# Bicomplexes
git subtree split --prefix=Bicomplexes -b Bicomplexes-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/Bicomplexes.jl.git Bicomplexes-split:master
echo "Pushed to Bicomplexes.jl"

# HomotopyCategories
git subtree split --prefix=HomotopyCategories -b HomotopyCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/HomotopyCategories.jl.git HomotopyCategories-split:master
echo "Pushed to HomotopyCategories.jl"

# DerivedCategories
git subtree split --prefix=DerivedCategories -b DerivedCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/DerivedCategories.jl.git DerivedCategories-split:master
echo "Pushed to DerivedCategories.jl"
