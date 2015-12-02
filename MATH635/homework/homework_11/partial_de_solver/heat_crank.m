function heat_crank(f,c1,c2,L,T,h,k,alpha)
% Solve the heat equation 
% with I.C. u(x,0)=f(x)
% and B.C. u(0,t)=c1, and u(L,t)=c2,
% using Crank-Nicolson method.
n=L/h;m=T/k; lambda=alpha*k/(h^2)
z=0:h:L;
disp('______________________________________________________________________')
fprintf('  t    x = ')
fprintf('%4.2f         ',z)
fprintf('\n')
disp('______________________________________________________________________')
fprintf('% 4.2f  ',0)
% Compute the values of u at t=0 
for i=1:n+1
    u(i)=feval(f,(i-1)*h); 
fprintf('%10.6f   ',u(i))
end
fprintf('\n')
for i=2:n
   if (i~=n) 
      % Compute the subdiagonal of A.
      a(i)=-lambda;
   end
   % Compute the main diagonal of A.
   b(i)=2*(1+lambda);
   if (i~=n)
      % Compute the superdiagonal of A.
      c(i)=-lambda;
   end 
end
% save the vecot b in bb.
bb=b;
for j=1:m
  t=j*k; 
  fprintf('% 4.2f  ',t)
% Compute the coefficient vector Bu.
  for i=2:n
     d(i)=lambda*u(i-1)+2*(1-lambda)*u(i)+lambda*u(i+1);
  end
 %Boundary conditions
  y(n+1)=c1;
  y(1)=c2;
 % Solve the tridiagonal system Au=Bu.
  for i=3:n
     ymult=a(i-1)/bb(i-1);
     bb(i)=bb(i)-ymult*c(i-1);
     d(i)=d(i)-ymult*d(i-1);
  end 
  y(n)=d(n)/bb(n);
  for i=n-1:-1:2
     y(i)=(d(i)-c(i)*y(i+1))/bb(i);
  end
  % Write the ouput.
     for i=1:n+1
       fprintf('%10.6f   ',y(i))
     end   
  fprintf('\n')   
  u=y;
  bb=b;
end

    

  
 
      
         
   