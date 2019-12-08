@propagate_inbounds function Base.to_indices(A, inds::Tuple{<:AbstractIndex, Vararg{Any}}, I::Tuple{Any, Vararg{Any}})
    Base.@_inline_meta
    (to_index(first(inds), first(I)), to_indices(A, maybetail(inds), tail(I))...)
end

@propagate_inbounds function Base.to_indices(A, inds::Tuple{<:AbstractIndex, Vararg{Any}}, I::Tuple{Colon, Vararg{Any}})
    Base.@_inline_meta
    (values(first(inds)), to_indices(A, maybetail(inds), tail(I))...)
end

@propagate_inbounds function Base.to_indices(A, inds::Tuple{<:AbstractIndex, Vararg{Any}}, I::Tuple{CartesianIndex{1}, Vararg{Any}})
    Base.@_inline_meta
    (to_index(first(inds), first(I)), to_indices(A, maybetail(inds), tail(I))...)
end

maybetail(::Tuple{}) = ()
maybetail(t::Tuple) = tail(t)

"""
    indices(x) -> Tuple
"""
function indices(x::AbstractArray)
    if is_static(x)
        return map(i -> SimpleIndex(OneToSRange(i)), size(x))
    elseif is_fixed(x)
        return map(i -> SimpleIndex(OneTo(i)), size(x))
    else
        return map(i -> SimpleIndex(OneToMRange(i)), size(x))
    end
end

function indices(x::AbstractArray{T,N}, dimnames::Tuple{Vararg{Union{Symbol,Nothing},N}}) where {T,N}
    if is_static(x)
        return map((d, s) -> SimpleIndex{d}(OneToSRange(s)), dimnames, size(x))
    elseif is_fixed(x)
        return map((d, s) -> SimpleIndex{d}(OneTo(s)), dimnames, size(x))
    else
        return map((d, s) -> SimpleIndex{d}(OneToMRange(s)), dimnames, size(x))
    end
end

