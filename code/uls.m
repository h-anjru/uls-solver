function uls(varinput, obsinput)
%ULS Unified least squares solver
%   varinput: Cell array of variables [name, value, sdev]
%   obsinput: Cell array of observations [name, value, sdev]
%  
%   When prompted for observation equations, write them in the form of an
%   anonymous function (e.g. @(c) c(1) * c(2) + c(3))

    % Extract numberical data into vectors
    % Generate directories for variables and observations
    [obs, var, s_obs, s_var, var_comp, obsrows] = ulsdir(obsinput, varinput);

    % Prompt user to build observation equations
    [eqinput] = ulsequations();

    % Prompt user to build "calls" to call variables in equations
    [eqvec] = ulscalls(obsrows, eqinput, var);

    % Build weight matrix
    [W] = ulsw(s_obs, s_var);

    % Solver (iterative)
    [varout, obsout] = ulsolver(obs, var, var_comp, eqvec, W);

end
