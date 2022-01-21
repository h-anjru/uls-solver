function [obs, var, s_obs, s_var, var_comp, obsrows] = ulsdir(obsinput, varinput)
%ULSDIR Extract numberical data into vectors
%   Generate directories for variables and observations

    obsname = obsinput(:, 1);
    obsnum = [1:size(obsinput, 1)]';
    obsindex = [obsname, num2cell(obsnum)];

    varname = varinput(:, 1);
    varnum = [1:size(varinput, 1)]';
    varindex = [varname, num2cell(varnum)];

    [obsrows, obscols] = size(obsindex);
    [varrows, varcols] = size(varindex);

    assignin('base', 'obsindex', obsindex);
    assignin('base', 'varindex', varindex);

    obs = cell2mat(obsinput(:, 2));
    var = cell2mat(varinput(:, 3));

    var_comp = var;

    s_obs = cell2mat(obsinput(:, 3));
    s_var = cell2mat(varinput(:, 3));

end