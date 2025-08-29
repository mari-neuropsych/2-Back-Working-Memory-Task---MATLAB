%% N-back Task (2-back) - Main Experiment
% Sleep & Working Memory Project
% Author: Mariam
% -------------------------------------------

clear; clc;

% General settings
nTrials = 20;       % number of trials
nBack   = 2;        % n-back value
stimDur = 1.5;      % stimulus duration (sec)

% Generate random letter sequence
letters = char(randi([65,90], [1,nTrials]));
isTarget = false(1,nTrials);

for t = (nBack+1):nTrials
    if rand < 0.25
        letters(t) = letters(t-nBack);
        isTarget(t) = true;
    end
end

% Arrays to store responses
resp = NaN(1,nTrials); 
rt   = NaN(1,nTrials);

disp('Instructions: Press Z if the letter matches the one from 2 steps back, M otherwise.');
pause(3);

% Main experiment loop
for t = 1:nTrials
    clc;
    fprintf('Trial %d/%d\n', t, nTrials);
    fprintf('Letter: %s\n', letters(t));

    tic; % start timing
    key = input('Press Z (target) or M (non-target): ','s');

    if strcmpi(key,'z')
        resp(t) = 1;
    elseif strcmpi(key,'m')
        resp(t) = 0;
    end

    rt(t) = toc; % reaction time
    pause(stimDur); 
end

% Save data in a table
T = table((1:nTrials)', letters', isTarget', resp', rt',...
    'VariableNames', {'Trial','Stimulus','IsTarget','Response','RT'});

% Write to CSV
writetable(T,'results.csv');

disp('Experiment finished! Data saved in results.csv');
