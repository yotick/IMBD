function H = filter_est(IH, IL,u1,u2)

% hor = fspecial('Prewitt');
% hor_f = freqz2(hor,size(IH)); % laplase matrix
% ver = hor';
% ver_f = freqz2(ver,size(IH));

lap = fspecial('laplacian',0);
lap_f = freqz2(lap,size(IH)); % laplase matrix
lap_f = ifftshift(lap_f);

A = fft2(IH)'.*fft2(IL);
% B = fft2(IH)'.*fft2(IL) + u1 + u2*(hor_f'.*hor_f + ver_f' .* ver_f);
B = fft2(IH)'.*fft2(IL) +u1+ u2*(lap_f'.*lap_f );

H =real(A./B);