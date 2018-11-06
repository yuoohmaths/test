#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Nov  2 19:22:52 2018
time-dependent Navier-Stokes equation

\partial u / \partial t + u\nabla u - \nu\delta u + \nabla p = f in \Omega * (0, T]
\nable u = 0 in \Omega * (0, T]
u = uD on \Tao * (0, T]
p = pN on \Tao * (0, T]
"""

from fenics import *
from mshr import *
parameters["form_compiler"]["representation"] = "uflacs"
parameters["form_compiler"]["cpp_optimize"] = True
list_linear_solver_methods()

fileU = File("outputs-NS-U.pvd")
fileP = File("outputs-NS-P.pvd")

# ********* Model coefficients and parameters ********* #

t = 0.0; dt = 0.01; T = 1.0;

sigma = Constant(1.0/dt)
nu    = Constant(0.001)

# ********* Mesh generation ********* #
r1 = Rectangle(Point(0,0),Point(4.0,1.0))
domain = r1
mesh = generate_mesh(domain,100)
mesh.smooth(120)
nn = FacetNormal(mesh)

# ******* Functions terms ****** #
# Initial functions
uin  = Expression(('4.0*x[1]*(1-x[1])','0.0'),degree=2)
f = Constant((0.0,0.0))
pout = Constant(0.0)

# ********* Finite dimensional spaces ********* #
P1 = FiniteElement("Lagrange", mesh.ufl_cell(), 1)
P2 = VectorElement("Lagrange", mesh.ufl_cell(), 2)
Vh = VectorFunctionSpace(mesh, "CG", 2)
P2P1 = P2 * P1
Hh = FunctionSpace(mesh, P2P1)

# test and trial functions for product space
(v, q) = TestFunctions(Hh)
Sol = Function(Hh); 
(u, p) = split(Sol) 

uold = interpolate(Constant((0.0,0.0)), Vh)

print( "Degrees of Freedom : ",   Hh.dim())

# ********* Boundaries and boundary conditions ********* #
# Left side
In=CompiledSubDomain("near(x[0],0.0)")
# Right side
Out=CompiledSubDomain("near(x[0],4.0)")
# Up and bottom
Wall=CompiledSubDomain("near(x[1],0.0) || near(x[1],1.0)")

bdry = MeshFunction("size_t", mesh, 1); bdry.set_all(0)
Wall.mark(bdry,30);
In.mark(bdry,31); Out.mark(bdry,32); 

# Velocity is 0 on the wall
bcUwall = DirichletBC(Hh.sub(0), Constant((0.0,0.0)), Wall)
# Velocity on the left side
bcUin = DirichletBC(Hh.sub(0), uin, In)
# Pressure on the right side
bcOut = DirichletBC(Hh.sub(1), pout, Out)
bcs = [bcUin,bcUwall,bcOut]
    
# ******** Weak forms ************* #

ustar = 0.5*(u + uold)

FF = 1.0/dt * dot(u,v)*dx \
     + dot(nabla_grad(ustar)*ustar,v) * dx \
     + nu*inner(nabla_grad(ustar),nabla_grad(v)) * dx \
     - p*div(v)*dx - q*div(ustar)*dx \
     - dot(f,v)*dx - 1.0/dt * dot(uold,v)*dx 

# ******* Solving *************** #

while (t <= T):

    print("t = ", t," / ",T)

    solve(FF == 0, Sol, bcs)
    
    (u_h,p_h) = Sol.split()

    assign(uold,u_h);

    u_h.rename("u","u"); fileU << (u_h,t)
    p_h.rename("p","p"); fileP << (p_h,t)
    
    t += dt;