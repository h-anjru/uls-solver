function [ varout, obsout ] = ulsolver( obs, var, var_comp, eqvec, W )
%ULSSOLVER Iterative unified least squares solver 

    % Preallocate jacobian matrix 
    J = zeros(size(obs, 1), size(var, 1));
    J = [J; eye(size(var, 1))];  % partial derivs of vars w/r/t themselves = 1

    % Preallocate (measured - computed) vector
    F = zeros(size(obs, 1) + size(var, 1), 1);

    % Preallocate delta vector with ones...
    delta = ones((size(obs, 1) + size(var, 1)), 1);

    % ...because the loop terminates when delta is more or less zero
    while sum(delta) > eps * size(delta, 1) % iterate to machine precision
        % Places numerical values of variables into eqvec
        for ii = 1:size(obs, 1)
            dd = cell2mat(eqvec(ii, 2));
            row = zeros(1, size(eqvec(ii, 2)));
            for jj = 1:size(eqvec{ii, 2}, 2)
                row(jj) = var_comp(dd(jj));
                % Variables stored as row in cell array
                eqvec(jj,3) = num2cell(row, [1 2]);
            end
        end
    
        % build Jacobian matrix
        for ii = 1:size(obs, 1)
            row = jacobianest(eqvec{ii, 1}, eqvec{ii, 3});
            dir = eqvec{ii, 2};
            for jj = 1:size(eqvec{ii, 2})
                J(ii, dir(jj)) = row(jj);
            end
        end
        
        % build (measured - computed) vector of constants
        for kk = 1:size(obs, 1)  % observations first...
            fun = eqvec{kk, 1};
            F(kk) = obs(kk) - fun(eqvec{kk, 3});  % see below
        end
        
        for mm = (size(obs, 1) + 1):size(delta, 1)  % ...then variables
            F(mm) = var(mm) - var_comp(mm);
        end
        
        delta = (W^0.5 * J) \ (W^0.5 * F);
        var_comp = var_comp + delta;
    end

    % Last update of var_comp is the final value of variables
    varout = var_comp;


    % Preallocate obsout
    obsout = zeros(size(obs, 1));

    % Last update of fun(eqvec{kk,3}) is final value of obs
    for nn = 1:size(obs,1)
        fun = eqvec{kk, 1};
        obsout(nn) = fun(eqvec{kk, 3});
    end

    assignin('base', 'varout', varout);
    assignin('base', 'obsout', obsout);

end
