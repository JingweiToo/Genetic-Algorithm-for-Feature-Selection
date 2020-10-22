function [sFeat,Sf,Nf,curve]=jGA2(feat,label,N,T,CR,MR,HO)

fun=@jFitnessFunction;
D=size(feat,2); X=zeros(N,D); 
for i=1:N
  for d=1:D
    if rand() > 0.5
      X(i,d)=1;
    end
  end
end
fit=zeros(1,N);  fitG=inf;
for i=1:N 
  fit(i)=fun(feat,label,X(i,:),HO);
  if fit(i) < fitG
    fitG=fit(i); Xgb=X(i,:);
  end
end
CR=round(CR*N); 
X1=zeros(CR,D); X2=zeros(CR,D); Fnew=zeros(1,2*CR); 
curve=inf; t=1;
%---Generations start------------------------------------------------------
while t <= T
  Ifit=1-fit; Prob=Ifit/sum(Ifit);
  for i=1:CR
    k1=jRouletteWheelSelection(Prob); 
    k2=jRouletteWheelSelection(Prob);
    P1=X(k1,:); P2=X(k2,:);
    ind=randi([1,D-1]);
    X1(i,:)=[P1(1:ind),P2(ind+1:D)]; 
    X2(i,:)=[P2(1:ind),P1(ind+1:D)];
  end
  Xnew=[X1;X2]; 
  for i=1:2*CR
    for d=1:D
      if rand() <= MR
        Xnew(i,d)=1-Xnew(i,d);
      end
    end
  end 
  for i=1:2*CR
    Fnew(i)=fun(feat,label,Xnew(i,:),HO);
    if Fnew(i) < fitG
      fitG=Fnew(i); Xgb=Xnew(i,:);
    end
  end 
  XX=[X;Xnew]; FF=[fit,Fnew]; 
  [FF,idx]=sort(FF,'ascend'); X=XX(idx(1:N),:); fit=FF(1:N); 
  curve(t)=fitG; 
  fprintf('\nIteration %d Best (GA)= %f',t,curve(t))
  t=t+1;
end
Pos=1:D; Sf=Pos(Xgb==1); Nf=length(Sf); sFeat=feat(:,Sf);  
end


function Route=jRouletteWheelSelection(Prob)
C=cumsum(Prob); P=rand();
for i=1:length(C)
	if C(i) > P
    Route=i; break;
  end
end
end

