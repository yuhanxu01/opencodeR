# Linear Algebra Fundamentals (English Version)

## 1. Matrix Basics

### 1.1 Matrix Definition

A matrix is an m×n array of numbers with m rows and n columns.

### 1.2 Special Matrices

- **Identity Matrix**: Diagonal elements are 1, others are 0
- **Diagonal Matrix**: Only diagonal elements are non-zero
- **Symmetric Matrix**: Satisfies A = Aᵀ
- **Orthogonal Matrix**: Satisfies AAᵀ = I

## 2. Eigenvalues and Eigenvectors

### 2.1 Definition

For a square matrix A, if there exists a non-zero vector v and a scalar λ such that:

```
Av = λv
```

Then λ is called an eigenvalue of matrix A, and v is the corresponding eigenvector.

### 2.2 Properties of Eigenvalues

- The trace of a matrix equals the sum of all eigenvalues
- The determinant of a matrix equals the product of all eigenvalues
- Eigenvalues of a symmetric matrix are all real numbers

### 2.3 Orthogonality of Eigenvectors

Eigenvectors corresponding to different eigenvalues of a symmetric matrix are orthogonal to each other.

## 3. Determinant

### 3.1 Definition

The determinant is a function that maps a square matrix to a scalar, denoted as det(A) or |A|.

### 3.2 Properties

- det(AB) = det(A)det(B)
- det(Aᵀ) = det(A)
- det(A⁻¹) = 1/det(A)

## 4. Matrix Decomposition

### 4.1 Eigenvalue Decomposition

For a diagonalizable matrix A:

```
A = PDP⁻¹
```

where D is a diagonal matrix of eigenvalues, and P is a matrix of eigenvectors.

### 4.2 Singular Value Decomposition (SVD)

Any m×n matrix A can be decomposed as:

```
A = UΣVᵀ
```

where:
- U is an m×m orthogonal matrix
- Σ is an m×n diagonal matrix (containing singular values)
- V is an n×n orthogonal matrix

## 5. Vector Spaces

### 5.1 Linear Independence

A set of vectors {v₁, v₂, ..., vₙ} is linearly independent if and only if:

```
c₁v₁ + c₂v₂ + ... + cₙvₙ = 0
```

holds only when all cᵢ = 0.

### 5.2 Basis and Dimension

A basis of a vector space is a set of linearly independent vectors that span the entire space. The number of vectors in the basis is called the dimension of the space.

## 6. Inner Product and Norm

### 6.1 Inner Product

The inner product of two vectors is defined as:

```
⟨u, v⟩ = u₁v₁ + u₂v₂ + ... + uₙvₙ
```

### 6.2 Norm

The norm (length) of a vector is defined as:

```
‖v‖ = √⟨v, v⟩
```
