function [sFeat,Sf,Nf,curve] = jGA1(feat,label,N,max_Iter,CR,MR,HO)

fun = @jFitnessFunction; 
dim = size(feat,2);
X   = zeros(N,dim); 
for i = 1:N
  for d = 1:dim
    if rand() > 0.5
      X(i,d) = 1;
    end
  end
end
fit  = zeros(1,N); 
fitG = inf;
for i = 1:N
  fit(i) = fun(feat,label,X(i,:),HO);
  if fit(i) < fitG
    fitG = fit(i); 
    Xgb  = X(i,:);
  end
end

curve = inf;
t = 1; 
%---Generations start------------------------------------------------
while t <= max_Iter
  Ifit = 1 - fit; 
  prob = Ifit / sum(Ifit);
  X1   = zeros(1,dim);
  X2   = zeros(1,dim);
  z    = 1;
  for i = 1:N
    if rand() < CR
      k1  = jRouletteWheelSelection(prob);
      k2  = jRouletteWheelSelection(prob);
      P1  = X(k1,:);
      P2  = X(k2,:);
      ind = randi([1, dim - 1]);
      X1(z,:) = [P1(1 : ind), P2(ind + 1 : dim)]; 
      X2(z,:) = [P2(1 : ind), P1(ind + 1 : dim)];
      z = z + 1;
    end
  end
  Xnew = [X1; X2];
  Nc   = size(Xnew,1); 
  Fnew = zeros(1,Nc);
  for i = 1:Nc
    for d = 1:dim
      if rand() <= MR
        Xnew(i,d) = 1 - Xnew(i,d);
      end
    end
  end 
  for i = 1:Nc
    Fnew(i) = fun(feat,label,Xnew(i,:),HO);
    if Fnew(i) < fitG
      Xgb  = Xnew(i,:); 
      fitG = Fnew(i);
    end
  end 
  XX  = [X; Xnew]; 
  FF  = [fit, Fnew]; 
  [FF, idx] = sort(FF,'ascend');
  X   = XX(idx(1:N),:); 
  fit = FF(1:N);
  
  curve(t) = fitG; 
  fprintf('\nIteration %d Best (GA)= %f',t,curve(t))
  t = t + 1;
end
Pos   = 1:dim; 
Sf    = Pos(Xgb == 1); 
Nf    = length(Sf); 
sFeat = feat(:,Sf); 
end


function Index = jRouletteWheelSelection(prob)
C = cumsum(prob); 
P = rand();
for i = 1:length(C)
	if C(i) > P
    Index = i;
    break;
  end
end
end


