function out = shrink(A, B)
out = sign(A).*max(abs(A)-B, 0);
