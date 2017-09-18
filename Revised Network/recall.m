function y = recall(M)
  y = diag(M) ./ sum(M,1)';
  y(isnan(y))=0;
end