function D = PSO(Vpv,Ipv)
persistent u;
persistent dcurrent;
persistent pbest;
persistent p;
persistent dc;
persistent v;
persistent counter;
persistent gbest;
if(isempty(counter))
    counter=0;
end
if(isempty(dcurrent))
    dcurrent=0.9;
end
if(isempty(gbest))
    gbest=0.9;
end
if(isempty(p))
    p=zeros(4,1);
end
if(isempty(v))
    v=zeros(4,1);
end
if(isempty(pbest))
    pbest=zeros(4,1);
end
if(isempty(u))
    u=0;
end
if(isempty(dc))
    dc=zeros(4,1);
    dc(1)=0.1910;
    dc(2)=0.3394;
    dc(3)=0.4279;
    dc(4)=0.4883;
end
if(counter>=1 && counter<300)
    D =dcurrent;
    counter=counter+1;
    return;
end
counter=0;
if(u>=1 && u<=4)
    if((Vpv*Ipv)>p(u))
        p(u)=Vpv*Ipv;
        pbest(u)=dcurrent;
    end
end
u=u+1;
if(u==6)
    u=1;
end
if(u==1)
    D=dc(u);
    dcurrent=D;
    counter=1;
    return;
elseif(u==2)
    D=dc(u);
    dcurrent=D;
    counter=1;
    return;
elseif(u==3)
    D=dc(u);
    dcurrent=D;
    counter=1;
    return;
elseif(u==4)
    D=dc(u);
    dcurrent=D;
    counter=1;
    return;
elseif(u==5)
    [m,i]=max(p);
    gbest=pbest(i);
    D=gbest;
    dcurrent=D;
    counter=1;
    %update velocity and duty cycle
    v(1)=updatevelocity(v(1),pbest(1),dc(1),gbest);
    v(2)=updatevelocity(v(2),pbest(2),dc(2),gbest);
    v(3)=updatevelocity(v(3),pbest(3),dc(3),gbest);
    v(4)=updatevelocity(v(4),pbest(4),dc(4),gbest);
    dc(1)=updateduty(dc(1),v(1));
    dc(2)=updateduty(dc(2),v(2));
    dc(3)=updateduty(dc(3),v(3));
    dc(4)=updateduty(dc(4),v(4));
    return;
else
    u
    D=0.1
end
end
function vfinal=updatevelocity(velocity,pobest,d,gwbest)
% PSO Parameters
w=0.4;
c1=1.2;         % Personal Learning Coefficient
c2=2;           % Global Learning Coefficient

vfinal = (w*velocity)+(c1*rand(1)*(pobest-d))+(c2*rand(1)*(gwbest-d));
end
function dfinal=updateduty(d,velocity)
dup=d+velocity;
if(dup>1)
    dfinal=1;
elseif(dup<0)
    dfinal=0;
else
    dfinal=dup;
end
end