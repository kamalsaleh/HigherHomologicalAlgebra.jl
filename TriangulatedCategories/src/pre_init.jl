# To avoid name clashes with ComplexesCategories, exclude these names
# from the exported namespace of TriangulatedCategories.
append!(ExcludedNames, [
  :MorphismAt,
  :MorphismAtOp,
  :ObjectAt,
  :ObjectAtOp,
])
