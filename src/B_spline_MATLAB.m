function tempo = B_spline_MATLAB(x,y,app)
    tic;
    cpts = [x; y];
    n=max(size(x));
    lim = n-3+2; %3 è il grado della b-spline (formula n-k+2)
    tpts = [0 lim];
    tvec = linspace(0,lim,500);
    
    Q = bsplinepolytraj(cpts,tpts,tvec);
    tempo = toc;
    plot(app.UIAxes,cpts(1,:),cpts(2,:),'ko','MarkerSize',3,'DisplayName','Punti di controllo'); hold(app.UIAxes,'on'); axis(app.UIAxes,'equal');
    plot(app.UIAxes,cpts(1,:),cpts(2,:),'--k','DisplayName','Poligono di controllo');
       
    plot(app.UIAxes,Q(1,:),Q(2,:),':b','DisplayName',strcat('Curva B-Spline MATLAB (di grado',32,num2str(3),')'));
    %32 è il codice ascii per lo spazio
    
    legend(legendUnq(app.UIAxes));
    

end