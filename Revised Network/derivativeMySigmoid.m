function y = derivativeMySigmoid(x)
% dLogisticSigmoid Derivative of the sigmoid.
%
    %Cheap estimation of derivative using mySigmoid Function
    y = mySigmoid(x).*(1 - mySigmoid(x));
end