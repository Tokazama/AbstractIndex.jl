module AbstractIndices

using LinearAlgebra, Statistics, NamedDims

import Base: length, axes, getindex, iterate, checkindex, checkbounds

# iterators
import Base: iterate, isdone, has_offset_axes
import Base.Iterators: Pairs

import Base: to_index, OneTo, tail, show, to_dim, values, keys
import NamedDims: unname

export AbstractIndex,
       IndexPosition,
       AxisIndex,
       OneToIndex,
       StaticKeys,
       NamedIndex,
       AbstractIndicesArray,
       IndicesArray,
       NamedAxes,
       # methods
       stepindex,
       asindex,
       # NamedDims
       NamedDimsArray,
       NamedIndicesArray,
       dimnames,
       # General - these combine the two
       filteraxes,
       findaxes,
       mapaxes



const TupOrVec{T} = Union{Tuple{Vararg{T}},AbstractVector{T}}


# TODO remove this once implemented in NamedDims
dimnames(::T) where {T} = dimnames(T)
dimnames(::Type{<:NamedDimsArray{names}}) where {names} = names
dimnames(::Type{<:AbstractArray{T, N}}) where {T, N} = ntuple(_->:_, N)

include("utils.jl")
include("abstractindex.jl")
include("abstractposition.jl")
include("abstractindicesarray.jl")
include("checkbounds.jl")
include("indexing.jl")
include("axes.jl")
include("indicesarray.jl")
include("math.jl")
include("reduce.jl")
include("subindices.jl")
include("interface.jl")

include("show.jl")

end



