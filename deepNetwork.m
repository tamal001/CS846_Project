clear
clc

%initialize variables
maxit = 100000;
alpha = 0.01;
n = 34;
out_interval = 1000;
nuron_l1 = 128;
nuron_l2 = 64;
nuron_l3 = 32;
scale = 0.0003;


%load images and labels and take first 1000 images
phu_data = load_phu_data('input.csv');
%phu_label= load_phu_label('Covid_data_phu2.csv');
phu_label= csvread('Covid_lebel.csv');
[rr,~] = size(phu_data);

%generate two level vectors train_y_actual and test_y_actual
train_y_actual = zeros(10,n);
for i=1:n
    train_y_actual(phu_label(i),i) = 1;
end

%Generate random weights
W1 = randn(nuron_l1,rr)*scale;
b1 = randn(nuron_l1,1)*scale;
W2 = randn(nuron_l2,nuron_l1)*scale;
b2 = randn(nuron_l2,1)*scale;
W3 = randn(10,nuron_l2)*scale;
b3 = randn(10,1)*scale;

%SGD training
sum_loss = 0;
iii = 1;

for it=1:maxit
    i = randi([1 n],1);
    x_i = phu_data(:,i);
    
    %forward pass
    z1 = W1*x_i+b1;
    h1 = phi_ReLU(z1);
    z2 = W2*h1+b2;
    h2 = phi_ReLU(z2);
    z3 = W3*h2+b3;
    y_i = phi_Softmax(z3);
        
    %backward propagation
    d_y_f = (-2) * (train_y_actual(:,i)-y_i);
    d_z3_f = jac_Softmax(y_i)' * d_y_f;
    grad_W3_f = d_z3_f * h2';
    grad_b3_f = d_z3_f;
    d_z2_f = jac_ReLU(z2)' * W3' * d_z3_f;
    grad_W2_f = d_z2_f * h1';
    grad_b2_f = d_z2_f;
    d_z1_f = jac_ReLU(z1)' * W2' * d_z2_f;
    grad_W1_f = d_z1_f * x_i';
    grad_b1_f = d_z1_f;
    
    %SGD update of the weights
    W1=W1 - alpha * grad_W1_f; b1=b1 - alpha * grad_b1_f;
    W2=W2 - alpha * grad_W2_f; b2=b2 - alpha * grad_b2_f;
    W3=W3 - alpha * grad_W3_f; b3=b3 - alpha * grad_b3_f;
    
    %calculate the loss function
    fw_i = norm(y_i - train_y_actual(:,i),2).^2;
    sum_loss = sum_loss + fw_i;
    
    if mod(it,out_interval)==0
        F = sum_loss/out_interval;
        disp("After "+it+" iterations, loss is: "+F);
        loss(iii) = F;
        iii = iii +1;
        sum_loss = 0;
    end
end
y = out_interval:out_interval:maxit;
plot(y,loss);
title('Loss function after every 1000 iteration');
xlabel('# of iterations');
ylabel('loss in accuracy');

%Computing loss function for the test set
correct = 0;
for i=1:n
    h1 = phi_ReLU(W1*phu_data(:,i)+b1);
    h2 = phi_ReLU(W2*h1+b2);
    y_model(:,i) = phi_Softmax(W3*h2+b3);
    label = y_model(1,i);
    ind = 1;
    for j=2:1:10
        if y_model(j,i)>label
            label = y_model(j,i);
            ind = j;
        end
    end
    if ind == phu_label(i)
        correct = correct + 1;
    end
end
disp("Correct Guess: "+correct);
