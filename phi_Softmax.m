function y = phi_Softmax(z)
% Usage: computes the probability vector y for real input vector z
% using the Softmax function; both z and y
% are column vectors with size equal to the number of classes
% (should work for any size)

len = size(z,1);
y = zeros(len, 1);
sum_exp = 0;
for i = 1:1:len
    sum_exp = sum_exp + exp(z(i));
end
for i = 1:1:len
    y(i) = exp(z(i))/sum_exp;
end