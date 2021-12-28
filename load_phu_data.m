function phu_data = load_phu_data(filename)
M = csvread(filename);
[r,c] = size(M);
%for i=1:r
%    max = 0;
%    for j=1:c
%        if M(i,j) > max
%            max = M(i,j);
%        end
%    end
%    for j=1:c
%        M(i,j) = (M(i,j)*255)/max;
%    end
%end

phu_data = M;