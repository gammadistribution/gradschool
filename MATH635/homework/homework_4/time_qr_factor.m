n = 50;

    T = tridiag(n);
    tic
    [Q_1,R_1] = qr_factor(T);
    time_1 = toc;

    tic
    [Q_2,R_2] = qr(T);
    time_2 = toc;

    if time_1 < time_2
        time_1
        time_2
    end

time_1
time_2