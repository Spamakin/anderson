-- Setup of variables
-- 10 variables
kk = QQ
R = kk[a,b,c,d,e,v,w,x,y,z]


-- Get ambient conditions
n = 5
A = matrix{
  {a, v},
  {b, w},
  {c, x},
  {d, y},
  {e, z}
}

Jn = n -> (
   -- Create n x n matrix with 1's on antidiagonals

   innerl := toList(n:0);
   outerl := toList(n:innerl);
   Jmut := mutableMatrix matrix outerl;

   for i from 0 to n - 1 do (
       Jmut_(i, n - 1 - i) = 1;
   );

   return matrix Jmut;
)

J = Jn(n)

ambientMatrix = transpose(A) * J * A
ambientConds = flatten entries ambientMatrix

-- Now we compute our counterexample
-- We are working with the signed permutation -(1, 2, 0, -2, 1)
-- See the pdf note I sent for the working of the conditions

-- The 2x2 minors we care about are top 4 rows
top4 = submatrix(A, {0..3},{0..1})
twoMinors = first entries gens minors(2, top4)

-- The whole ideal is defined by
--   the ambient conditions,
--   2x2 minors,
--   a, v
allConditions = join(ambientConds, twoMinors, {a, v})
I = ideal(allConditions)
Irad = radical I

-- However, only the 2x2 minors arise from essential condtions
essConditions = join(ambientConds, twoMinors)
Iess = ideal(essConditions)
Iessrad = radical Iess

-- We have that
-- I == Irad
-- Iess != Iessrad
-- I != Iess
-- I != Iessrad

