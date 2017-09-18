function y = mySigmoid(x)
% sigmoid activation function
%
    %Calculate Sigmoid function
    y = 1./(1 + exp(-x));
end