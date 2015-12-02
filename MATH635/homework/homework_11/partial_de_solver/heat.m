function [t_points, x_points, table] = heat(f,c1,c2,L,T,h,k,alpha)
% Solve the heat equation  
% with I.C. u(x,0)=f(x)
% and B.C. u(0,t)=c1 and u(L,t)=c2.
% using the Forward-Difference method
n=L/h;
m=T/k;

lambda=alpha*k/(h^2)

z=0:h:L;
x_points = z;

disp('______________________________________________________________________')
fprintf('  t    x = ')
fprintf('%4.2f         ',z)
fprintf('\n')
disp('______________________________________________________________________')
fprintf('% 5.4f  ',0)

% Compute the values of u at t=0 
for i=1:n+1
    u(i)=feval(f,(i-1)*h); 
fprintf('%10.6f   ',u(i))
end
fprintf('\n')

table = [u];
t_points = [0];

% Compute the values of u t=jk, k=1,2,...,m
for j=1:m
  t=j*k;
  t_points = [t_points, t];
  fprintf('% 5.4f  ',t)  
  for i=1:n+1
     if (i==1) 
        y(i)=c1; 
     elseif (i==n+1)
        y(i)=c2;
     else
        y(i)=(1-2*lambda)*u(i)+lambda*(u(i+1)+u(i-1));
     end;      
  fprintf('%10.6f   ',y(i))
  end;
  fprintf('\n')
  table = [table; y];
  u=y;
end;


    

  
 
      
         
   