#!/bin/bash

set -e

# Define GitHub username
if [ -z "$1" ]; then
  GITHUB_USER="homalg-project"
else
  GITHUB_USER="$1"
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
git subtree split --prefix=TriangulatedCategories -b TriangulatedCategories-split
git push git@github.com:${GITHUB_USER}/TriangulatedCategories.jl.git TriangulatedCategories-split:master
echo "Pushed to TriangulatedCategories.jl"

# ComplexesCategories
git subtree split --prefix=ComplexesCategories -b ComplexesCategories-split
git push git@github.com:${GITHUB_USER}/ComplexesCategories.jl.git ComplexesCategories-split:master
echo "Pushed to ComplexesCategories.jl"

# Bicomplexes
git subtree split --prefix=Bicomplexes -b Bicomplexes-split
git push git@github.com:${GITHUB_USER}/Bicomplexes.jl.git Bicomplexes-split:master
echo "Pushed to Bicomplexes.jl"

# HomotopyCategories
git subtree split --prefix=HomotopyCategories -b HomotopyCategories-split
git push git@github.com:${GITHUB_USER}/HomotopyCategories.jl.git HomotopyCategories-split:master
echo "Pushed to HomotopyCategories.jl"

# DerivedCategories
git subtree split --prefix=DerivedCategories -b DerivedCategories-split
git push git@github.com:${GITHUB_USER}/DerivedCategories.jl.git DerivedCategories-split:master
echo "Pushed to DerivedCategories.jl"
