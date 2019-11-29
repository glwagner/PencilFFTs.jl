"""
Module for multidimensional data decomposition using MPI.

Handles different decomposition configurations and data transpositions between
them. Also defines relevant data structures for handling distributed data.
"""
module Pencils

using MPI
using OffsetArrays
using Reexport
using TimerOutputs

import Base: @propagate_inbounds
import LinearAlgebra

export Pencil, PencilArray, MPITopology
export pencil
export gather
export get_comm, get_decomposition, get_permutation, get_timer
export global_view
export ndims_extra
export range_local, size_local, size_global
export transpose!

# Describes the portion of an array held by a given MPI process.
const ArrayRegion{N} = NTuple{N,UnitRange{Int}} where N

# Describes indices in an array as a tuple.
const Indices{N} = NTuple{N,Int} where N

const Permutation{N} = NTuple{N,Int} where N
const OptionalPermutation{N} = Union{Nothing, Permutation{N}} where N

# Modules
include("MPITopologies.jl")
using .MPITopologies
import .MPITopologies: get_comm

# Type definitions
include("pencil.jl")  # Pencil
include("arrays.jl")  # PencilArray

include("data_ranges.jl")
include("mpi_wrappers.jl")
include("permutations.jl")
include("transpose.jl")

end
