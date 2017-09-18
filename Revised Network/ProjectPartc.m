%Clear out variables and the console from previous runs so we don't have
%any trash left over
clc;
clear;
%Read the two CSV files in as arrays for use later
f1=fopen('training.txt');
format = [repmat('%i,', [1 18]) '%i'];
trainArray = fscanf(f1,format);
trainArray = reshape(trainArray,19,[]);
trainArrayResults = trainArray(14:19,:);
trainArray = trainArray(1:13,:);
%Can close this file index we're done with it
fclose(f1);
f2=fopen('testing.txt');
testArray = fscanf(f2,format);
testArray = reshape(testArray,19,[]);
testArrayResults = testArray(14:19,:);
testArray = testArray(1:13,:);
fclose(f2);

%Set some values for learning coeffecient and number of iterations
coeff = 0.05;
iterations = 10000;

%Set up our activation functions and derivative
actFunction = @mySigmoid;
dActFunction = @derivativeMySigmoid;

%Set number of hidden units
numHidden = 5;

%Train the Perceptron First
[hiddenWeights,outputWeights,error] = trainPerceptron(actFunction, dActFunction,numHidden,trainArray,trainArrayResults,iterations,coeff);

%Open and prepare output file
outputFile = fopen('PartCOutput.txt', 'w');
fprintf(outputFile,'----------------------------------------\nTraining Data Test:\n----------------------------------------\n');
%Then test it both against training data and testing data
[correctClass1,classErr1,correctClass2,classErr2,correctClass3,classErr3,correctClass4,classErr4,correctClass5,classErr5,correctClass6,classErr6, class1Results, class2Results, class3Results, class4Results, class5Results, class6Results, class1RealResults, class2RealResults, class3RealResults, class4RealResults, class5RealResults, class6RealResults] = validatePerceptron(actFunction,hiddenWeights,outputWeights,trainArray,trainArrayResults, outputFile);
fprintf(outputFile,'----------------------------------------\nTesting Data Test:\n----------------------------------------\n');
[correctClassTest1,classErrTest1,correctClassTest2,classErrTest2,correctClassTest3,classErrTest3,correctClassTest4,classErrTest4,correctClassTest5,classErrTest5,correctClassTest6,classErrTest6, class1ResultsTest, class2ResultsTest, class3ResultsTest, class4ResultsTest, class5ResultsTest, class6ResultsTest, class1RealResultsTest, class2RealResultsTest, class3RealResultsTest, class4RealResultsTest, class5RealResultsTest, class6RealResultsTest] = validatePerceptron(actFunction,hiddenWeights,outputWeights,testArray,testArrayResults, outputFile);
%And output summary of results (line by line output is handled in validate)
fprintf(outputFile,'----------------------------------------\nSummary For 20000 Iterations:\n----------------------------------------\n');
fprintf(outputFile,'Errors In Train Set: %d,%d,%d,%d,%d,%d\n', classErr1,classErr2,classErr3,classErr4,classErr5,classErr6);
fprintf(outputFile,'Correct In Train Set: %d,%d,%d,%d,%d,%d\n', correctClass1,correctClass2,correctClass3,correctClass4,correctClass5,correctClass6);
fprintf(outputFile,'Train Set identified: %.6f%%,%.6f%%,%.6f%%,%.6f%%,%.6f%%,%.6f%%\n', (correctClass1/(correctClass1+classErr1))*100,(correctClass2/(correctClass2+classErr2))*100,(correctClass3/(correctClass3+classErr3))*100,(correctClass4/(correctClass4+classErr4))*100,(correctClass5/(correctClass5+classErr5))*100,(correctClass6/(correctClass6+classErr6))*100);
fprintf(outputFile,'Errors In Test Set: %d,%d,%d,%d,%d,%d\n', classErrTest1,classErrTest2,classErrTest3,classErrTest4,classErrTest5,classErrTest6);
fprintf(outputFile,'Correct In Test Set: %d,%d,%d,%d,%d,%d\n', correctClassTest1,correctClassTest2,correctClassTest3,correctClassTest4,correctClassTest5,correctClassTest6);
fprintf(outputFile,'Train Set identified: %.6f%%,%.6f%%,%.6f%%,%.6f%%,%.6f%%,%.6f%%\n', (correctClassTest1/(correctClassTest1+classErrTest1))*100,(correctClassTest2/(correctClassTest2+classErrTest2))*100,(correctClassTest3/(correctClassTest3+classErrTest3))*100,(correctClassTest4/(correctClassTest4+classErrTest4))*100,(correctClassTest5/(correctClassTest5+classErrTest5))*100,(correctClassTest6/(correctClassTest6+classErrTest6))*100);
fprintf(outputFile,'Total identification rate: %.6f%%,%.6f%%,%.6f%%,%.6f%%,%.6f%%,%.6f%%\n',((correctClass1+correctClassTest1)/(correctClass1+classErr1+correctClassTest1+classErrTest1))*100,((correctClass2+correctClassTest2)/(correctClass2+classErr2+correctClassTest2+classErrTest2))*100,((correctClass3+correctClassTest3)/(correctClass3+classErr3+correctClassTest3+classErrTest3))*100,((correctClass4+correctClassTest4)/(correctClass4+classErr4+correctClassTest4+classErrTest4))*100,((correctClass5+correctClassTest5)/(correctClass5+classErr5+correctClassTest5+classErrTest5))*100,((correctClass6+correctClassTest6)/(correctClass6+classErr6+correctClassTest6+classErrTest6))*100);
fclose(outputFile);
matrixOutputFile = fopen('Confusion Matrix+Metrics.txt', 'w');
fprintf(matrixOutputFile,'----------------------------------------\nEngagement_Ranking_A Training:\n----------------------------------------\n');
confusion = confusionmat(class1RealResults,class1Results);
fprintf(matrixOutputFile,[repmat(' %d ',1 , 2) '\n'], confusion);
meanPrecision = mean(precision(confusion))*100;
meanRecall = mean(recall(confusion))*100;
fprintf(matrixOutputFile, '\nPrecision: %d%%\nRecall: %d%%\n', meanPrecision,meanRecall);
fprintf(matrixOutputFile,'----------------------------------------\nEngagement_Ranking_A Testing:\n----------------------------------------\n');
confusion = confusionmat(class1RealResultsTest,class1ResultsTest);
fprintf(matrixOutputFile,[repmat(' %d ',1 , 2) '\n'], confusion);
meanPrecision = mean(precision(confusion))*100;
meanRecall = mean(recall(confusion))*100;
fprintf(matrixOutputFile, '\nPrecision: %d%%\nRecall: %d%%\n', meanPrecision,meanRecall);
fprintf(matrixOutputFile,'----------------------------------------\nFrustration_Ranking_A Training:\n----------------------------------------\n');
confusion = confusionmat(class2RealResults,class2Results);
fprintf(matrixOutputFile,[repmat(' %d ',1 , 2) '\n'], confusion);
meanPrecision = mean(precision(confusion))*100;
meanRecall = mean(recall(confusion))*100;
fprintf(matrixOutputFile, '\nPrecision: %d%%\nRecall: %d%%\n', meanPrecision,meanRecall);
fprintf(matrixOutputFile,'----------------------------------------\nFrustration_Ranking_A Testing:\n----------------------------------------\n');
confusion = confusionmat(class2RealResultsTest,class2ResultsTest);
fprintf(matrixOutputFile,[repmat(' %d ',1 , 2) '\n'], confusion);
meanPrecision = mean(precision(confusion))*100;
meanRecall = mean(recall(confusion))*100;
fprintf(matrixOutputFile, '\nPrecision: %d%%\nRecall: %d%%\n', meanPrecision,meanRecall);
fprintf(matrixOutputFile,'----------------------------------------\nChallenge_Ranking_A Training:\n----------------------------------------\n');
confusion = confusionmat(class3RealResults,class3Results);
fprintf(matrixOutputFile,[repmat(' %d ',1 , 2) '\n'], confusion);
meanPrecision = mean(precision(confusion))*100;
meanRecall = mean(recall(confusion))*100;
fprintf(matrixOutputFile, '\nPrecision: %d%%\nRecall: %d%%\n', meanPrecision,meanRecall);
fprintf(matrixOutputFile,'----------------------------------------\nChallenge_Ranking_A Testing:\n----------------------------------------\n');
confusion = confusionmat(class3RealResultsTest,class3ResultsTest);
fprintf(matrixOutputFile,[repmat(' %d ',1 , 2) '\n'], confusion);
meanPrecision = mean(precision(confusion))*100;
meanRecall = mean(recall(confusion))*100;
fprintf(matrixOutputFile, '\nPrecision: %d%%\nRecall: %d%%\n', meanPrecision,meanRecall);
fprintf(matrixOutputFile,'----------------------------------------\nEngagement_Ranking_B Training:\n----------------------------------------\n');
confusion = confusionmat(class4RealResults,class4Results);
fprintf(matrixOutputFile,[repmat(' %d ',1 , 2) '\n'], confusion);
meanPrecision = mean(precision(confusion))*100;
meanRecall = mean(recall(confusion))*100;
fprintf(matrixOutputFile, '\nPrecision: %d%%\nRecall: %d%%\n', meanPrecision,meanRecall);
fprintf(matrixOutputFile,'----------------------------------------\nEngagement_Ranking_B Testing:\n----------------------------------------\n');
confusion = confusionmat(class4RealResultsTest,class4ResultsTest);
fprintf(matrixOutputFile,[repmat(' %d ',1 , 2) '\n'], confusion);
meanPrecision = mean(precision(confusion))*100;
meanRecall = mean(recall(confusion))*100;
fprintf(matrixOutputFile, '\nPrecision: %d%%\nRecall: %d%%\n', meanPrecision,meanRecall);
fprintf(matrixOutputFile,'----------------------------------------\nFrustration_Ranking_B Training:\n----------------------------------------\n');
confusion = confusionmat(class5RealResults,class5Results);
fprintf(matrixOutputFile,[repmat(' %d ',1 , 2) '\n'], confusion);
meanPrecision = mean(precision(confusion))*100;
meanRecall = mean(recall(confusion))*100;
fprintf(matrixOutputFile, '\nPrecision: %d%%\nRecall: %d%%\n', meanPrecision,meanRecall);
fprintf(matrixOutputFile,'----------------------------------------\nFrustration_Ranking_B Testing:\n----------------------------------------\n');
confusion = confusionmat(class5RealResultsTest,class5ResultsTest);
fprintf(matrixOutputFile,[repmat(' %d ',1 , 2) '\n'], confusion);
meanPrecision = mean(precision(confusion))*100;
meanRecall = mean(recall(confusion));
fprintf(matrixOutputFile, '\nPrecision: %d%%\nRecall: %d%%\n', meanPrecision,meanRecall);
fprintf(matrixOutputFile,'----------------------------------------\nChallenge_Ranking_B Training:\n----------------------------------------\n');
confusion = confusionmat(class6RealResults,class6Results);
fprintf(matrixOutputFile,[repmat(' %d ',1 , 2) '\n'], confusion);
meanPrecision = mean(precision(confusion))*100;
meanRecall = mean(recall(confusion))*100;
fprintf(matrixOutputFile, '\nPrecision: %d%%\nRecall: %d%%\n', meanPrecision,meanRecall);
fprintf(matrixOutputFile,'----------------------------------------\nChallenge_Ranking_B Testing:\n----------------------------------------\n');
confusion = confusionmat(class6RealResultsTest,class6ResultsTest);
fprintf(matrixOutputFile,[repmat(' %d ',1 , 2) '\n'], confusion);
meanPrecision = mean(precision(confusion))*100;
meanRecall = mean(recall(confusion))*100;
fprintf(matrixOutputFile, '\nPrecision: %d%%\nRecall: %d%%\n', meanPrecision,meanRecall);
