function [ eqinput ] = ulsequations()
%ULSEQUATIONS Prompt user to build observation equations
%   When prompted for observation equations, write them in the form of an
%   anonymous function (e.g. @(c) c(1) * c(2) + c(3))

    % Prompt user for number of distinct observation equation types
    eqnum = input('Number of distinct equation types: ');

    % Preallocate
    eqinput = cell(eqnum, 1);

    % Prompt for equations as anonymous functions
    for kk = 1:eqnum
        eqinput(kk, 1) = input('{[equation as anon function]}: ');
    end

    % Create equation directory, save to workspace
    eqdir = [eqvec, num2cell([1:eqnum]')];
    assignin('base', 'eqdir', eqdir);

end
