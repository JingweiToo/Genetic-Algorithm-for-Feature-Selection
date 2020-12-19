# Genetic Algorithm for Feature Selection

![Wheel](https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/d889846e-2797-49a7-b4c7-e67a15d118ff/6d964ba3-4b56-4e84-949a-470f340c878c/images/1595387337.PNG)


## Introduction
* Simple genetic algorithm ( GA ) for feature selection tasks, which can select the potential features to improve the classification accuracy. 
* The < Main.m file > illustrates the example of how GA can solve the feature selection problem using a benchmark data-set. 

## Input
* *feat*     : feature vector ( Instances *x* Features )
* *label*    : label vector ( Instances *x* 1 )
* *N*        : number of chromosomes
* *max_Iter* : maximum number of generations
* *CR*       : crossover rate
* *MR*       : mutation rate


## Output
* *sFeat*    : selected features
* *Sf*       : selected feature index
* *Nf*       : number of selected features
* *curve*    : convergence curve


### Example
```code
% Benchmark data set 
load ionosphere.mat; 

% Set 20% data as validation set
ho = 0.2; 
% Hold-out method
HO = cvpartition(label,'HoldOut',ho);

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

```


## Requirement
* MATLAB 2014 or above
* Statistics and Machine Learning Toolbox


## Cite As
```code
@article{too2020new,
  title={A new and fast rival genetic algorithm for feature selection},
  author={Too, Jingwei and Abdullah, Abdul Rahim},
  journal={The Journal of Supercomputing},
  pages={1--31},
  year={2020},
  publisher={Springer}
}


@article{too2019emg,
  title={EMG feature selection and classification using a Pbest-guide binary particle swarm optimization},
  author={Too, Jingwei and Abdullah, Abdul Rahim and Mohd Saad, Norhashimah and Tee, Weihown},
  journal={Computation},
  volume={7},
  number={1},
  pages={12},
  year={2019},
  publisher={Multidisciplinary Digital Publishing Institute}
}

```
