function [points, table] = laplace(f1,f2,g1,g2,a,n,itmax,tol)
% Solve the laplace equation in a square 
% with B.C.  u(x,0)=f1(x), u(x,a)=f2(x)
% and u(0,y)=g1(y) and u(a,y)=g2(y).
% using the five point difference method.
% Gauss-Seidel method is used to solve the linear system.
h=a/n;
z=0:h:a;
points = z;
h
disp('______________________________________________________________________')
fprintf('  u=  x\\y   ')
fprintf('%4.2f        ',z)
fprintf('\n')
disp('_____________________________________________________________________')
for i=1:n+1
   u(i,1)=feval(f1,(i-1)*h);
   u(i,n+1)=feval(f2,(i-1)*h);
   u(1,i)=feval(g1,(i-1)*h);
   u(n+1,i)=feval(g2,(i-1)*h);   
end
iter=0;
err=tol+1;
while (err>tol)&(iter<itmax)
   err=0;
   for i=2:n
      for j=2:n
         oldu=u(i,j);
         u(i,j)=(u(i+1,j)+u(i-1,j)+u(i,j+1)+u(i,j-1))/4;
         res=abs(u(i,j)-oldu);
         if (err<res);
            err=res;
         end
      end      
   end
   iter=iter+1;
end
for i=1:n+1
   fprintf('    %4.2f',z(i))
   for j=1:n+1
      fprintf('%10.4f  ',u(i,j))
   end
   fprintf('\n')
end
iter
table = u;
    

  
 
      
         
   