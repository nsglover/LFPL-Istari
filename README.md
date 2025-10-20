# Properties of LFPL - Formalized in the Istari Proof Assistant

This repository (**CURRENTLY INCOMPLETE**) defines Martin Hofmann's Linear Function Programming Language (LFPL) within Karl Crary's Istari Proof Assistant and proves several core properties of the language - soundness and completeness with respect to polynomial-time computation.

## Layout

The file structure consists of two general helper libraries (one defining some basic mathematical concepts and the other defining Turing machines), a definition of LFPL within Istari, a standard library for LFPL with lots of syntactic sugar and convenient helper functions, the polynomial-time soundness proof, and the polynomial-time completeness proof. See below for more details.

- `math`: Various mathematical definitions and results.
  - `nfold.ist`: Defines $n$-fold and indexed operations (such as the $n$-fold composition of a function $f : A \to A$ with itself or an indexed sum over a sequence of natural numbers).
  - `div.ist`: Natural number division (with remainder).
  - `exp.ist`: Definition of and basic lemmas about exponentiation on natural numbers.
  - `binom.ist`: Definition of the binomial coefficient and a proof of the binomial theorem.
  - `poly.ist`: Definition of and basic lemmas about natural-coefficient polynomials.
- `machine`: (**INCOMPLETE**) A definition of general Turing machines and polynomial-time Turing machines.
  - `tape.ist`: Defines the tape of a Turing machine as a 3-tuple of the left section, head symbol, and right section of the tape.
  - `transition.ist`: Defines the state and transition function of a Turing machine.
- `lfpl/core`: The syntax and semantics of LFPL.
  - `language.ist`: Contains types, contexts, context splitting, and well-typed terms.
  - `substitution.ist`: Defines substitutions from context variables to values.
  - `semantics.ist`: Gives denotational semantics from LFPL types and terms into Istari types and terms.
- `lfpl/completeness`: (**INCOMPLETE**) Proves that LFPL is polynomial-time complete - it can encode any function computable  by a polynomial-time Turing machine.
- `lfpl/soundness`: (**INCOMPLETE**) Proves that LFPL is polynomial-time sound - all functions encodable in LFPL are computable by a polynomial-time Turing machine.
  - `size.ist`: Defines the size of an LFPL value, intuitively representing the number of diamonds that value contains, and proves the non-size-increasing theorem - all functions encodable in LFPL do not increase the size of their input. In other words, diamonds are never created, only passed around and possibly destroyed.
- `lfpl/lib/heap-free`: LFPL library for heap-free types.
  - `sugar.ist`: Defines heap-free types and provides syntactic sugar for contraction at such types.
  - `complete.ist`: Proves heap-free completeness - that LFPL can encode any function $f : A \to B$, where $A$ and $B$ are the semantic objects corresponding to two heap-free types.
- `lfpl/lib/list`: LFPL library for lists.
  - `sugar.ist`: Derives a friendlier interface for lists (nil, cons, foldr, foldl, and list case) from the primitive fold and rec operations on LFPL lists.
  - `tools.ist`: Append and list suspension.
- `lfpl/lib/nat`: LFPL library for natural numbers (unit lists).
  - `sugar.ist`: Derives zero, succ, and primitive recursion from nil, cons, and foldr.
  - `tools.ist`: Tools for reasoning about unit lists.
  - `memory.ist`: Tools for reasoning about tuples of natural numbers, which in LFPL can be viewed as structured chunks of free diamonds. This is primarily used in the stack library.
- `lfpl/lib/stack`: LFPL library for $(k, s)$-bounded stacks, where $k : \mathbb{N}$ and $s : \mathbb{N} \to \mathbb{N}$. Whereas LFPL lists can only hold $n$ values given $n$ diamonds, these stacks hold up to $s(n)$ values given $0$ diamonds by suspending them under a lambda abstraction. To actually store and retrieve these values via the stack operations (push and pop), a pool of $nk$ diamonds is needed. These diamonds will only be temporarily borrowed, not consumed, by the stack operations. Notably, we can inductively construct $(k, n \mapsto cn^k)$-stacks, obtaining polynomial storage space with linear expenses.
  - `interace.ist`: Defines an interface for $(k, s)$-bounded stacks and for reasoning about their correctness.
  - `weakened.ist`: Weakens a $(k, s)$-stack to a $(k + 1, s)$-stack.
  - `additive.ist`: Given a $(k, s_1)$-stack and a $(k, s_2)$-stack, constructs a $(k, n \mapsto s_1(n) + s_2(n))$-stack.
  - `base.ist`: The base case of the inductive construction; builds a $(0, n \mapsto c)$-stack.
  - `inductive.ist`: The inductive case of the inductive construction; given a $(k, s)$-stack, builds a $(k + 1, n \mapsto n s(n))$-stack.
  - `polynomial.ist`: Puts everything together to construct a $(k, P)$-stack, where $P$ is a polynomial and $k$ is the degree of $P$.
