
%  FUZZY LOGIC WASHING MACHINE SYSTEM


clc;
clear;
close all;

fis = mamfis('Name','WashingMachine');

fis = addInput(fis,[0 10],'Name','Dirt');

fis = addMF(fis,'Dirt','trapmf',[0 0 2 4],'Name','Low');
fis = addMF(fis,'Dirt','trimf',[2 5 8],'Name','Medium');
fis = addMF(fis,'Dirt','trapmf',[6 8 10 10],'Name','High');

fis = addInput(fis,[0 10],'Name','Load');

fis = addMF(fis,'Load','trapmf',[0 0 2 4],'Name','Small');
fis = addMF(fis,'Load','trimf',[2 5 8],'Name','Medium');
fis = addMF(fis,'Load','trapmf',[6 8 10 10],'Name','Large');

fis = addOutput(fis,[0 60],'Name','Time');

fis = addMF(fis,'Time','trapmf',[0 0 10 20],'Name','Short');
fis = addMF(fis,'Time','trimf',[15 30 45],'Name','Medium');
fis = addMF(fis,'Time','trapmf',[40 50 60 60],'Name','Long');

%% Rule
% Format: [Dirt Load Time Weight Operator]
rules = [
    1 1 1 1 1;  % Low + Small → Short
    2 1 2 1 1;  % Medium + Small → Medium
    3 1 3 1 1;  % High + Small → Long
    1 2 1 1 1;  % Low + Medium → Short
    2 2 2 1 1;  % Medium + Medium → Medium
    3 2 3 1 1;  % High + Medium → Long
    1 3 2 1 1;  % Low + Large → Medium
    2 3 3 1 1;  % Medium + Large → Long
    3 3 3 1 1;  % High + Large → Long
];

fis = addRule(fis, rules);


disp('------------- FUZZY RULES -------------');
showrule(fis)

%% VISUALIZATION 
figure('Name','Dirt Membership Functions');
plotmf(fis,'input',1);
grid on;

figure('Name','Load Membership Functions');
plotmf(fis,'input',2);
grid on;

figure('Name','Time Membership Functions');
plotmf(fis,'output',1);
grid on;

%% TEST CASES 
disp('------------- TEST OUTPUTS -------------');

test_inputs = [
    2 2;
    5 5;
    8 9;
];

for i = 1:size(test_inputs,1)
    output = evalfis(fis,test_inputs(i,:));
    
    fprintf('Input (Dirt=%.1f, Load=%.1f) --> Time = %.2f minutes\n',...
        test_inputs(i,1), test_inputs(i,2), output);
end

%% SAVE SYSTEM 
writeFIS(fis,'washing_machine.fis');

%%  RULE VIEWER 
ruleview(fis);