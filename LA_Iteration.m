%Basic Formulation
%Finite Difference form of Laplace’s equation
%

nx = 100;
ny = 100;
niter = 200;

V = zeros(nx,ny);

%q/k == 0;

dvt = 1;
dvb = 1;

vt = 0; %what top V is pinned to (when dvt=0)
vb = 0; %what bot V is pinned to (when dvb=0)

%cond1 left BC is 1, right BC is 0, derivative of top and bottom are 0
% vl = 1;
% vr = 0;

%cond2 left BC is 1, right BC is 1, derivative of top and bottom are 0
vl = 1;
vr = 1;

figure(1)
for i = 1:niter
    for m = 2:(nx-1)
        for n = 2:(ny-1)
            V(1,:) = vl;
            V(nx,:) = vr;
            if ~dvt
                V(:,ny) = vt; %if dvt=0, V top is pinned to vt
            else
                V(:,ny) = V(:,ny-1); %if dvt=1, V top has derivative of 0
            end
            if ~dvb
                V(:,1) = vb; %if dvb=0, V bot is pinned to vb
            else
                V(:,1) = V(:,2); %if dvb=1, V bot has derivative of 0
            end
            V(m,n) = ((V(m+1,n) + V(m-1,n) + V(m,n+1) + V(m,n-1)))/4;
        end
    end
    if mod(i,50) == 0 %only plots once every 50 times through
        surf(V')
        pause(0.05)
    end
end

[Ex, Ey] = gradient(V); %plotting gradient
    
figure(2)
quiver(-Ey',-Ex',10) %vector arrows
pause(0.001)

