function out = m_pad(A,m,n)
%% pad with 0 at right side and bottom of the matrix
[m_A, n_A] = size(A);
if m<m_A||n<n_A
    error(message('MATLAB:the padding size is too small'))
end
out = [ [A;zeros(m-m_A, n_A)] zeros(m,n-n_A)];
end