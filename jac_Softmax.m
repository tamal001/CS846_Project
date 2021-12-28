function J_Softmax = jac_Softmax(y)
% Usage: computes the Jacobian matrix of the Softmax
% function evaluated in weighted input vector z, but we give
% the Softmax output y as input to the jac_Softmax(y) function
% because the Jacobian formulas can easily be expressed
% as a function of y; this matrix is not diagonal but it is symmetric
% (should work for input y of any size)

len = size(y,1);
J_Softmax = zeros(len);

for j = 1:1:len
    for k=1:1:len
        if j == k
            J_Softmax(j,k) = y(j) - y(j)*y(j);
        else
            J_Softmax(j,k) = -(y(j)*y(k));
        end
    end
end