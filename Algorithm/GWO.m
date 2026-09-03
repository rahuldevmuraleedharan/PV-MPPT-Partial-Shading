% Define the function GWO with inputs Vpv and Ipv
function D =GWO(Vpv,Ipv)

% Declare persistent variables
persistent u; % Variable to keep track of the current iteration
persistent dcurrent; % Current duty cycle
persistent pbest; % Personal best position of each wolf
persistent p; % Power output of each wolf
persistent dc; % Duty cycle of each wolf
persistent v; % Velocity of each wolf
persistent counter; % Counter for iterations
persistent gbest; % Global best position

% Initialize variables if they are empty
if (isempty(counter))
    counter=0;
end
if (isempty(dcurrent))
    dcurrent=0.9;
end
if (isempty(gbest))
    gbest=0.9;
end
if (isempty(p))
    p=zeros(4,1);
end
if(isempty(v))
    v=zeros(4,1);
end
if (isempty(pbest))
    pbest=zeros(4,1);
end
if (isempty(u))
    u=0;
end
if (isempty(dc))
    dc=zeros(4,1);
    dc(1)=0;
    dc(2)=0.3;
    dc(3)=0.5;
    dc(4)=0.7;
end

% If counter is between 1 and 300, return the current duty cycle
if (counter>=1 && counter<300)
    D=dcurrent;
    counter=counter+1;
    return;
end

% Reset counter
counter=0;

% Update personal best position and power output
if (u>=1 && u<=4)
    if((Vpv*Ipv)>p(u))
        p(u)=Vpv*Ipv;
        pbest(u)=dcurrent;
    end
end

% Increment u
u=u+1;

% Reset u if it exceeds 5
if (u==6)
    u=1;
end

% Update duty cycle and counter based on the value of u
if (u==1)
    D=dc(u);
    dcurrent=D;
    counter=1;
    return;
elseif (u==2)
    D=dc(u);
    dcurrent=D;
    counter=1;
    return;
elseif (u==3)
    D=dc(u);
    dcurrent=D;
    counter=1;
    return;
elseif (u==4)
    D=dc(u);
    dcurrent=D;
    counter=1;
    return;
elseif (u==5)
    [m,i]=max(p);
    gbest=pbest(i);
    D=gbest;
    dcurrent=D;
    counter=1;
    %update velocity
    v(1)=updatevelocity(v(1),pbest(1),dc(1),gbest);
    v(2)=updatevelocity(v(2),pbest(2),dc(2),gbest);
    v(3)=updatevelocity(v(3),pbest(3),dc(3),gbest);
    v(4)=updatevelocity(v(4),pbest(4),dc(4),gbest);
    %update duty cycle
    dc(1)=updateduty(dc(1),v(1),gbest);
    dc(2)=updateduty(dc(2),v(2),gbest);
    dc(3)=updateduty(dc(3),v(3),gbest);
    dc(4)=updateduty(dc(4),v(4),gbest);
    return;
else
    u
    D=0.1
end
end

% Define the function updatevelocity with inputs velocity, pobest, d, and gwbest
function vfinal=updatevelocity(velocity,pobest,d,gwbest)
C=2*rand; % Random constant
vfinal=(C*pobest-d); % Update velocity
end

% Define the function updateduty with inputs d, velocity, and gwbest
function dfinal=updateduty(d,velocity,gwbest)
A=2*0.1*rand-0.1; % Random constant
dup=gwbest-A*velocity; % Update duty cycle
if(dup>1)
    dfinal=1;
elseif(dup<0.1)
    dfinal=0.1;
else
    dfinal=dup;
end
end