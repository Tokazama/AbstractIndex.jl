"""
    permute_axes(x::AbstractArray, p::Tuple) = permute_axes(axes(x), p)
    permute_axes(x::NTuple{N}, p::NTuple{N}) -> NTuple{N}

Returns axes of `x` in the order of `p`.

## Examples
```
julia> permute_axes((Index{:a}(1:10), Index{:b}(1:10), Index(1:10)), (:b, 3, :a))
(Index{a}(1:10 => Base.OneTo(10)), Index(1:10 => Base.OneTo(10)), Index{b}(1:10 => Base.OneTo(10)))
```
"""
permute_axes(x::AbstractArray{T,N}, p::NTuple{N}) where {T,N} = permute_axes(axes(x), p)
permute_axes(x::NTuple{N,Any}, p::NTuple{N,Any}) where {N} = permute_axes(x, to_dims(x, p))
permute_axes(x::NTuple{N,Any}, p::NTuple{N,Int}) where {N} = map(i -> getfield(x, i), p)

"""
    permute_axes(x::AbstractVector)

Returns the permuted axes of `x` as axes of size 1 × length(x)

## Examples
```
julia> permute_axes((Index(1:4),))
(Index(1:1 => Base.OneTo(1)), Index(1:4 => Base.OneTo(4)))
```
"""
permute_axes(x::AbstractVector) = permute_axes(axes(x))
permute_axes(x::NTuple{1,Any}) = (reduce_axis(unname(first(x))), first(x))

"""
    permute_axes(m::AbstractMatrix) -> NTuple{2}

Permute the axes of the matrix `m`, by flipping the elements across the diagonal
of the matrix. Differs from LinearAlgebra's transpose in that the operation is
not recursive.

## Examples
```
julia> permute_axes((Index{:a}(1:4), Index{:b}(1:4)))
(Index{b}(1:4 => Base.OneTo(4)), Index{a}(1:4 => Base.OneTo(4)))
```
"""
permute_axes(x::AbstractMatrix) = permute_axes(axes(x))
permute_axes(x::NTuple{2,Any}) = (last(x), first(x))

