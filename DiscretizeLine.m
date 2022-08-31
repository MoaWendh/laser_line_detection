% Discretizes a lines
% Pedro Buschinelli, 2019
% p1 and p2 [d x N]
% d = dimensions, eg: 1, 2, 3.
% N = number of points = must be 1 ( for now :P )
function [pts] = DiscretizeLine(p1, p2, delta)

v0 = p2-p1;
% Line lenght
w = norm(v0);

% Line direction
v0 = v0/norm(v0);

% Points
N = round(w/delta) + 1;
N = ceil(N);%round up

pts = nan(size(p1,1),N);

pts(:,1) = p1;
pts(:,N) = p2;

for i = 2:N-1
    pt = pts(:,i-1) + v0*delta;
    pts(:,i) = pt;
end

mustRound = 1;
if mustRound
    pts = round(pts);
end


end

