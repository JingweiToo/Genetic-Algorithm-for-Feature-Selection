%-------------------------------------------------------------------%
%  Genetic Algorithm (GA) demo version                              %
%-------------------------------------------------------------------%


%---Input------------------------------------------------------------
% feat     : feature vector (instances x features)
% label    : label vector (instance x 1)
% N        : Number of chromosomes
% max_Iter : Maximum number of generations
% CR       : Crossover rate
% MR       : Mutation rates

%---Output-----------------------------------------------------------
% sFeat    : Selected features (instances x features)
% Sf       : Selected feature index
% Nf       : Number of selected features
% curve    : Convergence curve
%--------------------------------------------------------------------


%% Genetic Algorithm (version 1) 
clc, clear, close 
% Benchmark data set 
load ionosphere.mat; 

% Set 20% data as validation set
ho = 0.2; 
% Hold-out method
HO = cvpartition(label,'HoldOut',ho,'Stratify',false);

% Parameter setting
N        = 10;
max_Iter = 100;
CR       = 0.8;
MR       = 0.3; 
% Genetic Algorithm
[sFeat,Sf,Nf,curve] = jGA1(feat,label,N,max_Iter,CR,MR,HO); 

% Plot convergence curve
plot(1:max_Iter,curve);
xlabel('Number of generations');
ylabel('Fitness Value'); 
title('GA'); grid on;


%% Genetic Algorithm (version 2) 
clc, clear, close 
% Benchmark data set 
load ionosphere.mat; 

% Set 20% data as validation set
ho = 0.2; 
% Hold-out method
HO = cvpartition(label,'HoldOut',ho,'Stratify',false);

% Parameter setting
N        = 10;
max_Iter = 100; 
CR       = 0.6; 
MR       = 0.001; 
% Genetic Algorithm
[sFeat,Sf,Nf,curve] = jGA2(feat,label,N,max_Iter,CR,MR,HO);

% Plot convergence curve
plot(1:max_Iter,curve);
xlabel('Number of generations');
ylabel('Fitness Value'); 
title('GA'); grid on;




