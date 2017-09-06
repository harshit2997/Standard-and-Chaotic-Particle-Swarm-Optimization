clc;
clear all;

%swarm definition
d=2;
n=50;
smin=1*ones(1,d);
smax=100*ones(1,d);
m1=1;
m2=100;
wmin=0.2;
wmax=1.2;
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
%iniitalizing the swarm
for i=1:n
  swarm(i).pos=unifrnd(smin,smax,1,d);
  swarm(i).cost=cost_func(swarm(i).pos);
  swarm(i).vel=rand(1,d);
  swarm(i).pos_pbest=swarm(i).pos;
  swarm(i).pbest=cost_func(swarm(i).pos_pbest);
  if swarm(i).pbest>gbest
    gbest=swarm(i).pbest;
    pos_gbest=swarm(i).pos_pbest;
  end
end

for t=1:max_iter
  
  n=size(swarm,1);
  w=wmax;
  
  for i=1:n
  %calculation of personal bests
    if (swarm(i).cost > swarm(i).pbest)
      swarm(i).pos_pbest=swarm(i).pos;
      swarm(i).pbest=swarm(i).cost;
    end
  %calculation of global best  
    if (swarm(i).pbest > gbest)
      pos_gbest=swarm(i).pos_pbest;
      gbest=swarm(i).pbest;
    end
   
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
   
  %update valocities and positions
    swarm(i).vel=w*swarm(i).vel+alpha*rand(1,d).*(pos_gbest-swarm(i).pos)+beta*rand(1,d).*(swarm(i).pos_pbest-swarm(i).pos);  
    swarm(i).pos=swarm(i).pos+swarm(i).vel;
    
    swarm(i).pos=max(swarm(i).pos,smin);
    swarm(i).pos=min(swarm(i).pos,smax);
    
    swarm(i).cost=cost_func(swarm(i).pos);
    
    
    
    
   
 
  end
  
  %retain best n/5 particles
  [~, SortOrder]=sort([swarm.cost]);
  swarm=swarm(SortOrder);
  swarm=flipud(swarm);
  swarm2=swarm((1+(1*n/5)):n,:);
  swarm=swarm(1:(1*n/5),:);
  
 %chaotic local search for best particle out of n/5 retained particles
  temp=swarm(1).pos;
% disp ([num2str(cost_func(temp))]);
% clsv=(swarm(1).pos-smin)./(smax-smin);
%  clsv_n=1*clsv.*(1-clsv);
%  if cost_func(smin+clsv_n.*(smax-smin))>swarm(1).cost
%  swarm(1).pos=smin+clsv_n.*(smax-smin);
%  end
% swarm(1).pos=min(swarm(1).pos,smax);
%swarm(1).pos=max(swarm(1).pos,smin);
  
%  swarm(1).cost=cost_func(swarm(1).pos);
%  disp ([num2str(swarm(1).cost)]);

  clsv=(pos_gbest-smin)./(smax-smin);
  clsv_n=4*clsv.*(1-clsv);
%  if cost_func(smin+clsv_n.*(smax-smin))>swarm(1).cost
  pos_gbest=smin+clsv_n.*(smax-smin);
%  end
 pos_gbest=min(pos_gbest,smax);
 pos_gbest=max(pos_gbest,smin);
 gbest=cost_func(pos_gbest);
 
%  disp ([num2str(smin) '           ' num2str(smax)])
  l2=size(swarm2,1);
  
  %new values of min and max
  %r=rand(1,d);
  r=0.6;
  smin=max(smin,pos_gbest-r*(smax-smin));  
 % smin=min((m1+m2)/2,smin);
  smax=min(smax,pos_gbest+r*(smax-smin));
 % smax=max((m1+m2)/2,smax);
  

  %get random 4n/5 particles
  new_swarm=repmat(part,l2,1);
  for i=1:l2
    new_swarm(i).pos=unifrnd(smin,smax,1,d);
    new_swarm(i).cost=cost_func(new_swarm(i).pos);
    new_swarm(i).pbest=swarm2(i).pbest;
    new_swarm(i).pos_pbest=swarm2(i).pos_pbest;
    new_swarm(i).vel=rand(1,d);
  end
  
  swarm=[swarm
         new_swarm]; 
  
%  w=w*wdamp;
  disp(['Iteration : ' num2str(t) ' Minimum value = ' num2str(swarm(1).cost) ' Best solution is : ' num2str(swarm(1).pos)]);
end