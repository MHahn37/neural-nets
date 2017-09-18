function [ hiddenWeights, outputWeights, error ] = trainPerceptron( actFunction, dActFunction, numHidden, inputValues, targetValues, iterations, coeff )
%TRAINPERCEPTRON Function to train perceptron
%   

    %How many samples we have
    trainingSize = size(inputValues,2);

    %How many dimensions in each
    inputDims = size(inputValues,1);

    %How many output Dims we should have
    outputDims = size(targetValues,1);


    %seeds rand off the current clock, then sets weights to a rand
    rng('shuffle');
    % Initialize the weights for the hidden layer and the output layer.
    hiddenWeights = rand(numHidden, inputDims);
    outputWeights = rand(outputDims, numHidden);
    hiddenWeights = hiddenWeights./size(hiddenWeights, 2);
    outputWeights = outputWeights./size(outputWeights, 2);

    n = zeros(trainingSize);
    error = 0;
    
    for i = 1:iterations
        for k = 1: trainingSize;
            %Propogate Input vector through network
            n(k) =  floor(rand(1)*trainingSize + 1);
            inputVector = inputValues(:,n(k));
            hiddenActualInput = hiddenWeights*inputVector;
            hiddenOutputVector = actFunction(hiddenActualInput);
            outputActualInput = outputWeights*hiddenOutputVector;
            outputVector = actFunction(outputActualInput);


            targetVector = targetValues(:,n(k));
            %Backpropogate the error
            outDelta = dActFunction(outputActualInput).*(outputVector-targetVector);
            hiddenDelta = dActFunction(hiddenActualInput).*(outputWeights'*outDelta);

            outputWeights = outputWeights - coeff.*outDelta*hiddenOutputVector';
            hiddenWeights = hiddenWeights - coeff.*hiddenDelta*inputVector';         
        end
        %Calculate the error using MSE
        error = error + 1/i * sum((targetVector-actFunction(outputWeights*actFunction(hiddenWeights*inputVector))).^2);
        error = error/trainingSize;
    end
end

