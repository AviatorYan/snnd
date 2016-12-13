function distances = snnd(X, k,primary_method, secondary_method, use_parallel )
% snns - Returns the shared nearest neighbour distances between samples in X
% Calculates shared nearest neighbour distances as defined in: Houle, M., Kriegel, 
% H-P., Kröger, P., Schubert, E., Zimek, A. in "Can Shared-Neighbor Distances Defeat
% the Curse of Dimensionality?", Proceedings of the 22nd International Conference on
% Scientific and Statistical Database Management, June 31 – July 2, 2010, Heidelberg, Germany 
%
% Syntax:  distances = snns(X, k, primary_method, secondary_method, use_parallel )
%
% Inputs:
%    X - NxD matrix of samples
%    k - Neighbourhood size (default = 10)
%    primary_method - Method used in the primary distance calculations (default='euclidean')
%    secondary_method - Method used to calculate the distances (default='inverse')
%    use_parallel = Will parallel similarity calculations be performed? (default=true)
%
% Outputs:
%    distances - Shared nearest neighbour distances between samples in X
%
% Example:
%    snnd(X,20)
%
% Other m-files required: snns.m
%
% Author: Robert Ciszek
% Decomber 2016; Last revision: 12-December-2016

	if ~exist('k', 'var')
                k = 10;
        end

        if ~exist('primary_method', 'var')
                primary_method  = 'euclidean';
        end

        if ~exist('secondary_method', 'var')
                secondary_method = 'inverse';
        end

        if ~exist('use_parallel', 'var')
                use_parallel = true;
        end

	%Calculate the nearest neighbour similarities between samples
	similarities = snns(X,k,primary_method, 'simcos',use_parallel);

	if strcmp(secondary_method,'inverse')
		distances = 1 - similarities;
	end 
	
        if strcmp(secondary_method,'arccos')
                distances = acos(similarities);
        end

        if strcmp(secondary_method,'ln')
                distances = log(similarities + eps);
        end


end
