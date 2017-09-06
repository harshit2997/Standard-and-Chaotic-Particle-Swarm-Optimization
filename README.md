# Standard-and-Chaotic-Particle-Swarm-Optimization
MATLAB implementations of standard and chaos-incorporated versions of the particle swarm optimization metaheuristic tested on continuous optimization functions. Particle swarm optimization (PSO) is a swarm intelligence based metaheuristic used for mathematical optimization, inspired by the movement and swarming of fish, birds in nature.

**main_pso_cont.m** - Standard PSO with damping applied on the weight of memory of the previous iteration's velocity.

**main_cpso_cont.m** - Chaotic PSO with Logistic map applied for chaotic local search in the best 1/5th particles and random initialization of rest of the particles (reference paper [here](http://www.sciencedirect.com/science/article/pii/S0960077905000330)).

The Booth, Goldstien-Price, Levi N.13, Griewank, Sphere function are also implemented in separate files to be used as the objective function.
