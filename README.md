# Properties of LFPL - Formalized in the Istari Proof Assistant

This repository defines Martin Hofmann's Linear Function Programming Language (LFPL) within Karl Crary's Istari Proof Assistant and proves two core properties of the language - soundness and completeness with respect to polynomial-time computation. These two together imply that the complexity class of functions definable in LFPL is precisely equal to FP (the class of polynomial-time function problems).

## Layout

The file structure consists of two general helper libraries (one defining some basic mathematical concepts and the other defining Turing machines), a definition of LFPL within Istari, a standard library for LFPL with lots of syntactic sugar and convenient helper functions, the polynomial-time soundness proof, and the polynomial-time completeness proof. See below for more details.

- `math`: Various mathematical definitions and results.
  - `nfold.ist`: Defines $n$-fold and indexed operations (such as the $n$-fold composition of a function $f : A \to A$ with itself or an indexed sum over a sequence of natural numbers).
  - `div.ist`: Natural number division (with remainder).
  - `exp.ist`: Definition of and basic lemmas about exponentiation on natural numbers.
  - `binom.ist`: Definition of the binomial coefficient and a proof of the binomial theorem.
  - `poly.ist`: Definition of and basic lemmas about natural-coefficient polynomials.
- `turing-machine`: A definition of general Turing machines and polynomial-time Turing machines.
  - `tape.ist`: Defines the tape of a Turing machine as a 3-tuple of the left section, head symbol, and right section of the tape.
  - `transition.ist`: Defines the state and transition function of a Turing machine.
  - `machine.ist`: Defines Turing machines via general recursion, and provides a terminating interface for Turing machines which always halt. For convenience, these definitions are instantiated for polynomial-time Turing machines.
- `lfpl/core`: The syntax and semantics of LFPL.
  - `language.ist`: Defines types, contexts, context splitting, well-typed terms, and heap-free types.
  - `operational.ist`: Gives a big-step operational semantics for LFPL. The language for values (to which terms are evaluated) include a value of diamond type so that we can reason about the runtime of programs which use nonempty lists. This is necessary since LFPL does not have any closed terms of diamond type.
  - `denotational.ist`: Gives a denotational semantics from LFPL types and terms into Istari types and terms.
  - `equivalence.ist`: Proves that the operational semantics is deterministic, and (assuming the denotational semantics for values is reasonable) that it is equivalent to the denotational semantics.
- `lfpl/soundness`: Proves that LFPL is polynomial-time sound - all functions encodable in LFPL are computable in polynomal-cost (per the big-step operational cost semantics defined in `lfpl/core`).
  - `size.ist`: Defines the size of an LFPL value, intuitively representing the number of diamonds that value contains, and proves the non-size-increasing theorem - all functions encodable in LFPL do not increase the size of their input. In other words, diamonds are never created, only passed around and possibly destroyed.
  - `bound.ist`: Defines cost-bounding polynomials for terms, values, and evaluation environments. The latter two polynomials are necessary since the function closure value contains a term that may incur further cost in the future. The main polynomial cost bound theorem for general LFPL programs is also proven here.
  - `theorems.ist`: As a corollary of the theorem in `bound.ist`, we prove a concrete soundness theorem that states the cost of running an LFPL function on lists with a list of length $n$ is bounded by a polynomial in $n$.
- `lfpl/completeness`: Proves that LFPL is polynomial-time complete - it can encode any function computable  by a polynomial-time Turing machine.
  - `tape.ist`: Using the stack library (see below), gives an implementation of Turing machine tapes in LFPL.
  - `step.ist`: Implements the stepping procedure of a Turing machine, wherein the tape is written to and shifted according to the output of the machine's transition function on the tape head and current machine state.
  - `iteration.ist`: Implements a polynomial iteration procedure in LFPL, where given a function $f : A \; \text{list} \to A \; \text{list}$ and input $l : A \; \text{list}$, we can run this function $P(n)$ times (where $n$ is the length of the list and $P$ is a polynomial).
  - `machine.ist`: Combines all the above pieces to encode the process of running a polynomial-time Turing machine, which amounts to iterating the step function $P(n)$ times on an input list of length $n$.
  - `theorems.ist`: Statements and proofs of the main polynomial-time completeness theorems.
- `lfpl/lib/heap-free`: LFPL library for heap-free types.
  - `sugar.ist`: Provides syntactic sugar for contraction at such types.
  - `surjective.ist`: Proves heap-free surjectivity - that LFPL can encode any element $A$ or function $f : A \to B$, where $A$ and $B$ are the semantic objects corresponding to two heap-free types.
- `lfpl/lib/tuple`: LFPL library for $n$-ary tensor products.
  - `sugar.ist`: Defines the tuple type.
  - `tools.ist`: Tuple rotation.
- `lfpl/lib/list`: LFPL library for lists.
  - `sugar.ist`: Derives a friendlier interface for lists (nil, cons, foldr, foldl, and list case) from the primitive fold and rec operations.
  - `tools.ist`: Append and list suspension (separates the diamonds and values of a list, turns an $L(A)$ into an $L(1) \to L(A)$ and an L(1)).
- `lfpl/lib/nat`: LFPL library for natural numbers (unit lists).
  - `sugar.ist`: Derives zero, succ, and primitive recursion from nil, cons, and foldr.
  - `memory.ist`: Tools for reasoning about tuples of natural numbers, which in LFPL can be viewed as structured chunks of free diamonds. This is primarily used in the stack library.
  - `division.ist`: Implements division (by a compile-time constant) for LFPL nats.
- `lfpl/lib/stack`: LFPL library for $(k, s)$-bounded stacks, where $k : \mathbb{N}$ and $s : \mathbb{N} \to \mathbb{N}$. Whereas LFPL lists can only hold $n$ values given $n$ diamonds, these stacks hold up to $s(n)$ values given $0$ diamonds by suspending them under a lambda abstraction. To actually store and retrieve these values via the stack operations (push and pop), a pool of $nk$ diamonds is needed. These diamonds will only be temporarily borrowed, not consumed, by the stack operations. Notably, we can inductively construct $(k, n \mapsto cn^k)$-stacks, obtaining polynomial storage space with linear expenses.
  - `interace.ist`: Defines an interface for $(k, s)$-bounded stacks and for reasoning about their correctness.
  - `weakened.ist`: Weakens a $(k, s)$-stack to a $(k + 1, s)$-stack.
  - `additive.ist`: Given a $(k, s_1)$-stack and a $(k, s_2)$-stack, constructs a $(k, n \mapsto s_1(n) + s_2(n))$-stack.
  - `base.ist`: The base case of the inductive construction; builds a $(0, n \mapsto c)$-stack.
  - `inductive.ist`: The inductive case of the inductive construction; given a $(k, s)$-stack, builds a $(k + 1, n \mapsto n s(n))$-stack.
  - `polynomial.ist`: Puts everything together to construct a $(k, P)$-stack, where $P$ is a polynomial and $k$ is the degree of $P$.
