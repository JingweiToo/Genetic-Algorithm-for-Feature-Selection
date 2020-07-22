%-------------------------------------------------------------------------%
%  Genetic Algorithm (GA) source codes demo version                       %
%                                                                         %
%  Programmer: Jingwei Too                                                %
%                                                                         %
%  E-Mail: jamesjames868@gmail.com                                        %
%-------------------------------------------------------------------------%

function [sFeat,Sf,Nf,curve]=jGA2(feat,label,N,T,CR,MR)
%---Inputs-----------------------------------------------------------------
% feat:  features
% label: labelling
% N:     Number of chromosomes
% T:     Maximum number of generations
% CR:    Crossover rate
% MR:    Mutation rate
%---Outputs----------------------------------------------------------------
% sFeat: Selected features
% Sf:    Selected feature index
% Nf:    Number of selected features
% curve: Convergence curve
%--------------------------------------------------------------------------


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
  fit(i)=fun(feat,label,X(i,:));
  if fit(i) < fitG
    fitG=fit(i); Xgb=X(i,:);
  end
end
CR=round(CR*N); 
X1=zeros(CR,D); X2=zeros(CR,D); Fnew=zeros(1,2*CR); curve=inf; t=1;
figure(1); clf; axis([1 100 0 0.3]); xlabel('Number of generations');
ylabel('Fitness Value'); title('Convergence Curve'); grid on;
%---Generations start------------------------------------------------------
while t <= T
  Ifit=1-fit; Prob=Ifit/sum(Ifit);
  for i=1:CR
    k1=jRouletteWheelSelection(Prob); k2=jRouletteWheelSelection(Prob);
    P1=X(k1,:); P2=X(k2,:);
    ind=randi([1,D]);
    X1(i,:)=[P1(1:ind),P2(ind+1:D)]; X2(i,:)=[P2(1:ind),P1(ind+1:D)];
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
    Fnew(i)=fun(feat,label,Xnew(i,:));
    if Fnew(i) < fitG
      fitG=Fnew(i); Xgb=Xnew(i,:);
    end
  end 
  XX=[X;Xnew]; FF=[fit,Fnew]; 
  [FF,idx]=sort(FF,'ascend'); X=XX(idx(1:N),:); fit=FF(1:N); 
  curve(t)=fitG; 
  pause(1e-20); hold on;
  CG=plot(t,fitG,'Color','r','Marker','.'); set(CG,'MarkerSize',5);
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

