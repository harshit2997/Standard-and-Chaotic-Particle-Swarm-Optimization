clc;
clear all;

d=2;
n=50;
smin=1;
smax=100;
wmin=0.2;
wmax=1.2;
w=1;
wdamp=0.99;
alpha=2;
beta=2;
max_iter=1000;

cost_func=@(x) Fac(x);

part=struct();
part.pos=[];
part.cost=Inf;
part.pbest=Inf;
part.pos_pbest=[];
part.vel=[];

swarm=repmat(part,n,1);

gbest=-Inf;
pos_gbest=[];

for i=1:n
  swarm(i).pos=unifrnd(smin,smax,1,d);
  swarm(i).cost=cost_func(swarm(i).pos);
  swarm(i).vel=zeros(1,d);
  swarm(i).pos_pbest=swarm(i).pos;
  swarm(i).pbest=cost_func(swarm(i).pos_pbest);
  if swarm(i).pbest>gbest
    gbest=swarm(i).pbest;
    pos_gbest=swarm(i).pos_pbest;
  end
end

for t=1:max_iter
  
  for i=1:n
  
    [~, SortOrder]=sort([swarm.cost]);
    swarm=swarm(SortOrder);
    swarm=flipud(swarm);
  %calculation of new inertia weight factor  
    avg=sum([swarm.cost])/n;
    if swarm(i).cost>avg
      w=wmin+((wmax-wmin)*(swarm(i).cost-swarm(1).cost)/(avg-swarm(1).cost));
    else
      w=wmax;
    end 
%    disp([num2str(swarm(i).pbest)]);
    swarm(i).vel=w*swarm(i).vel+alpha*rand(1,d).*(pos_gbest-swarm(i).pos)+beta*rand(1,d).*(swarm(i).pos_pbest-swarm(i).pos);  
    swarm(i).pos=swarm(i).pos+swarm(i).vel;
    swarm(i).pos=max(swarm(i).pos,smin);
    swarm(i).pos=min(swarm(i).pos,smax);
    swarm(i).cost=cost_func(swarm(i).pos);
%    disp([num2str(swarm(i).cost < swarm(i).pbest)]);
    if (swarm(i).cost > swarm(i).pbest)
      swarm(i).pos_pbest=swarm(i).pos;
      swarm(i).pbest=swarm(i).cost;
    end
    if (swarm(i).pbest > gbest)
      pos_gbest=swarm(i).pos_pbest;
      gbest=swarm(i).pbest;
    end
    
  end
%  w=w*wdamp;
  disp(['Iteration : ' num2str(t) ' Minimum value = ' num2str(gbest) ' Best solution is : ' num2str(pos_gbest)]);
end
   
  
