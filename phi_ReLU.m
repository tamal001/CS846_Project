function h = phi_ReLU(z)
% Usage: computes the activation vector h for weighted input vector z
% using the ReLU activation function componentwise; both z and h
% are column vectors of the same size (should work for any size)

len = size(z,1);

h = zeros(len,1);
for i = 1:1:len
    if z(i) < 0
        h(i) = 0;
    else
        h(i) = z(i);
    end
end