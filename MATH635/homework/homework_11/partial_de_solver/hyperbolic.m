function [x_points, t_points, table] = hyperbolic(f,g,c1,c2,L,T,h,k,alpha)
% Solve the hyperbolic equation 
% with u(x,0)=f(x), ut(x,0)=g(x). 
% and u(0,t)=c1 and u(L,t)=c2,
% using a three level explicit method.

n=L/h;m=T/k;
lambda=alpha*k/h

z=0:h:L;
x_points = z;


disp('______________________________________________________________________')
fprintf('  t    x = ')
fprintf('%4.2f         ',z)
fprintf('\n')
disp('______________________________________________________________________')
fprintf('% 4.2f  ',0)

% Compute the values of u at t=0 
for i=1:n+1
   u0(i)=feval(f,(i-1)*h); 
   fprintf('%10.6f   ',u0(i))
end
fprintf('\n')
fprintf('% 4.2f  %10.6f   ',k,c1)

%Compute the values of u at t=k 
for i=1:n-1
   u1(i+1)=(1-lambda^2)*feval(f,i*h)+lambda^2/2*(feval(f,(i+1)*h)...
        +feval(f,(i-1)*h))+k*feval(g,i*h);  
   fprintf('%10.6f   ',u1(i+1))
end
t_points = [0, k];
table = [u0; [u1, c2]];

fprintf('%10.6f   ',c2)
fprintf('\n')
%Compute the values of u at t>k
for j=2:m
  t=j*k;
  t_points = [t_points, t];
  
  fprintf('% 4.2f  ',t)
  %Boundary condition
  u1(1)=c1; ui(1)=c1; u1(n+1)=c2; ui(n+1)=c2;
  fprintf('%10.6f   ',ui(1))
  for i=2:n
     ui(i)=2*(1-lambda^2)*u1(i)+lambda^2*(u1(i+1)...
           +u1(i-1))-u0(i);  
     fprintf('%10.6f   ',ui(i))
  end
  fprintf('%10.6f   ',ui(n+1))
  fprintf('\n')
  u0=u1;
  u1=ui;
  table = [table; ui];
end


    

  
 
      
         
   