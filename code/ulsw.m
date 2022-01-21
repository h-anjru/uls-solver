function [W] = ulsw(s_obs, s_var)
%ULSW Builds combined independent weight matrix
%   Assumes observations and variables are uncorrelated

    wvec = [s_obs; s_var];

    W = diag(wvec.^-1);

end

