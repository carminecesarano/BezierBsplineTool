function tempo = B_spline_custom(x,y,p,app)
%% HELP - B_spline_custom(x,y,p,app) - Generazione e plotting di curve B-Spline di grado p
% dati i punti di controllo (x,y)
%
% La funzione prende in ingresso una coppia di vettori riga 'x' e 'y'
% contenenti le coordinate (x,y) dei punti di controllo che formano
% il convex hull, entro il quale si vuole generare una curva Spline
% di grado 'p', acquisito anch'esso in input. La firma della funzione consta del parametro
% in ingresso 'app', che permette di interfacciarla al grafico nel toolbox BBSToolbox.

%% Inizializzazione delle variabili
tic;
%k=k+1; % Ordine della curva = grado del polinomio +1
n=max(size(x)); % numero di punti di controllo
div = 500; %risoluzione (numero di istanti su cui viene valutata la Spline)con distanza 1/div
%% Calcolo della Spline
%Open Uniform Knot Vector - convenzione per disporre che la curva passi per
%i punti iniziale e finale del poligono di controllo (convenzione)

j=n+p+1; %limite del vettore dei knots

%si parte da 1 perchè MATLAB non ammette l'indice del vettore pari a 0
%questo condiziona l'algoritmo poichè si usa k+1 al posto di k
for i=1:j 
   if i<p+2
       t(i)=0;
   elseif (i>=p+2 && i<=n+1)
       t(i)=i-p-1;             % i-k instead of i-k+1
   else
       t(i)=n-p;              % n-k+1 instead of n-k+2
    end;
end;

um = n-p; %limite dell'intervallo di definizione della Spline (valore massimo tra i nodi)
u = linspace(0,um,div); %intervallo di definizione delle B-Spline
index = 1; %indice per le matrici X e Y
%ciclo sugli istanti di tempo 
for j=1:max(size(u))
    x1=0; y1=0;
    %ciclo sui punti di controllo
    for i=1:n
        
        N=CoxDeBoor(t,p+1,u(j),i);  % funzione di calcolo delle funzioni B-Spline
                                    % mediante formula ricorsiva di Cox-DeBoor
                                    % Si ottiene la funzione di base N(i,p)
        
                                    % calcolata all'istante u(j)
                                    
        %valore parziale delle coordinate della Spline all'istante u(j),
        %ovvero C(i,u(j))
        x1=x1+(N*x(i)); 
        y1=y1+(N*y(i));
    end;
    
   %coordinate della spline all'istante u(j), ovvero C(u(j))
   X(index)=x1;
   Y(index)=y1;
   index=index+1; %incremento dell'indice
end
tempo = toc;
%% Plotting dei risultati

plot(app.UIAxes,x,y,'ko','MarkerSize',3,'DisplayName','Punti di controllo'); hold(app.UIAxes,'on');  axis(app.UIAxes,'equal');
plot(app.UIAxes,x,y,'--k','DisplayName','Poligono di controllo');

plot(app.UIAxes,X,Y,'r','DisplayName',strcat('Curva B-Spline di grado',32,num2str(p)));
%32 è il codice ascii per lo spazio
legend(legendUnq(app.UIAxes));

    