function [eqvec] = ulscalls(obsrows, eqinput, var)
%ULSCALLS Prompts user to identify variables used in observation equations.
%   See uls.

    eqvec = cell(obsrows, 3);  %third column populated in ulsolver

    % Prompts user to identify variables used in each observation equation
    for kk = 1:obsrows
        eq = input('Equation #: ');
        eqvec(kk, 1) = eqinput(eq);
        
        cc = input('Variables used in equation {[as row}]: ');
        eqvec(kk, 2) = cc;
    end


end

