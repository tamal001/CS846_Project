function J_ReLU = jac_ReLU(z)
% Usage: computes the Jacobian matrix of the ReLU activation
% function evaluated in weighted input vector z;
% this is a diagonal matrix (should work for input z of any size)

len = size(z,1);
J_ReLU = zeros(len);
for i=1:1:len
    if z(i) >= 0
        J_ReLU(i,i) = 1;
    end
end