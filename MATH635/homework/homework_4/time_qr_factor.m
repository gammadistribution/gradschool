n = 50;

for i = 1:n
    T = tridiag(i);
    tic
    [Q_1,R_1] = qr_factor(T);
    time_1 = toc;

    tic
    [Q_2,R_2] = qr(T);
    time_2 = toc;

    if time_1 < time_2
        i, time_1, time_2
    end
end
