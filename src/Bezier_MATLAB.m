function tempo = Bezier_MATLAB(x,y,app)
    tic;
    N = max(size(x));
    P = [x(:) y(:)];
    syms t;
    B = bernsteinMatrix(N-1,t);
    BezierCurve = simplify(B*P);
    
    plot(app.UIAxes,P(:,1), P(:,2),'ko','MarkerSize',3,'DisplayName','Punti di controllo');  hold(app.UIAxes,'on'); axis(app.UIAxes,'equal');
    plot(app.UIAxes,P(:,1), P(:,2),'--k','DisplayName','Poligono di controllo');
    fplot(app.UIAxes,BezierCurve(1),BezierCurve(2),[0 1],'DisplayName','Curva di Bezier MATLAB');
    tempo = toc;
    legend(legendUnq(app.UIAxes));
    
   
end