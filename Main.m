%-------------------------------------------------------------------------%
%  Genetic Algorithm (GA) source codes demo version                       %
%                                                                         %
%  Programmer: Jingwei Too                                                %
%                                                                         %
%  E-Mail: jamesjames868@gmail.com                                        %
%-------------------------------------------------------------------------%


%---Input------------------------------------------------------------------
% feat:  feature vector (instances x features)
% label: labelling
% N:     Number of chromosomes
% T:     Maximum number of generations
% CR:    Crossover rate
% MR:    Mutation rates
%*Note: k-value of KNN & hold-out setting can be modified in jFitnessFunction.m
%---Output-----------------------------------------------------------------
% sFeat: Selected features (instances x features)
% Sf:    Selected feature index
% Nf:    Number of selected features
% curve: Convergence curve
%--------------------------------------------------------------------------


%% Genetic Algorithm (version 1) 
clc, clear, close 
% Benchmark data set 
load ionosphere.mat; 
% Parameter setting
N=10; T=100; CR=0.8; MR=0.3; 
% Genetic Algorithm
[sFeat,Sf,Nf,curve]=jGA1(feat,label,N,T,CR,MR); 
% Plot convergence curve
figure(); plot(1:T,curve); xlabel('Number of generations');
ylabel('Fitness Value'); title('GA'); grid on;


%% Genetic Algorithm (version 2) 
clc, clear, close 
% Benchmark data set 
load ionosphere.mat; 
% Parameter setting
N=10; T=100; CR=0.6; MR=0.001; 
% Genetic Algorithm
[sFeat,Sf,Nf,curve]=jGA2(feat,label,N,T,CR,MR);
% Plot convergence curve
figure(); plot(1:T,curve); xlabel('Number of generations');
ylabel('Fitness Value'); title('GA'); grid on;




