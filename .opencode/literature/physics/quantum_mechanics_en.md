# Quantum Mechanics Fundamentals (English Version)

## 1. Wave Function

In quantum mechanics, the wave function ψ(x,t) describes the quantum state of a particle. The square of the wave function's magnitude |ψ(x,t)|² represents the probability density of finding the particle at position x and time t.

## 2. Schrödinger Equation

### 2.1 Time-Dependent Schrödinger Equation

The time-dependent Schrödinger equation is:

```
iℏ ∂ψ/∂t = Ĥψ
```

where:
- i is the imaginary unit
- ℏ is the reduced Planck constant
- Ĥ is the Hamiltonian operator

### 2.2 Hamiltonian Operator

The Hamiltonian operator defines the total energy of the system, including kinetic and potential energy:

```
Ĥ = -ℏ²/2m ∇² + V(x)
```

where:
- m is the particle mass
- V(x) is the potential energy function

## 3. Eigenvalue Problem

### 3.1 Energy Eigenvalues

The time-independent Schrödinger equation is an eigenvalue equation:

```
Ĥψ = Eψ
```

Here E is the energy eigenvalue, and ψ is the corresponding eigenstate (eigenvector).

### 3.2 Orthogonality of Eigenvectors

Different energy eigenstates satisfy the orthonormality condition:

```
⟨ψₘ|ψₙ⟩ = δₘₙ
```

## 4. Lagrangian and Hamiltonian

### 4.1 Lagrangian

In classical mechanics, the Lagrangian is defined as kinetic energy minus potential energy:

```
L = T - V
```

### 4.2 From Lagrangian to Hamiltonian

The Hamiltonian can be obtained from the Lagrangian via Legendre transformation:

```
H = pq̇ - L
```

where p is the generalized momentum and q̇ is the generalized velocity.

## 5. Fourier Transform

Fourier transforms are commonly used in quantum mechanics to convert between position and momentum space:

```
ψ̃(p) = 1/√(2πℏ) ∫ ψ(x) e^(-ipx/ℏ) dx
```

## 6. Uncertainty Principle

The Heisenberg uncertainty principle states that position and momentum cannot be simultaneously measured with arbitrary precision:

```
Δx Δp ≥ ℏ/2
```

This is a fundamental limitation in quantum mechanics.
