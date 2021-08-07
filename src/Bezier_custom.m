function tempo = Bezier_custom(x,y,app)
%% HELP Bézier_custom(x,y,app) - Generazione e plotting di curve di Bezier dati i punti di controllo
% (x,y)
%
% La funzione prende in ingresso una coppia di vettori riga 'x' e 'y',
% contenenti le coordinate (x,y) dei punti di controllo che formano
% il convex hull, entro il quale si vuole generare una curva di Bezier.
% La firma della funzione consta del parametro in ingresso 'app',
% che permette di interfacciarla al grafico nel toolbox BBSToolbox.

%% Inizializzazione delle variabili
tic;
div = 500; % Numero di istanti di tempo in cui valutare l'espressione analitica della curva
n = size(x,2); %numero di coordinate (punti di controllo) che definiscono la poligonale
% (convex hull)

P(1,:) = x;
P(2,:) = y;

index = 1; %inizializzazione dell'indice per la valutazione delle funzioni di blending
% (polinomi di Bernstein) agli istanti t

u = linspace(0,1,div); % suddivisione dell'intervallo [0,1], in cui sono definite
% le funzioni di Bernstein, in div sottointervalli equispaziati 
% (con distanza 1/div). I sottointervalli sono determinati dagli istanti in cui si valutano le
% componenti polinomiali di Bernstein: l'interpolazione lineare della
% successione dei div punti calcolati determina l'andamento della curva di Bezier 
% (di grado N se N+1 sono i punti di controllo).

%% Core dell'algoritmo

% calcolo della curva di Bezier mediante combinazione lineare del prodotto
% tra funzioni di blending e punti di controllo, valutati in ogni istante t=u(j)

% Primo ciclo: istanti di tempo t=u(j) in cui la combinazione lineare è
% valutata (COMPLESSITA' DI CALCOLO CRESCENTE PER VALORI DI DIV CRESCENTE,
% MA RISOLUZIONE MIGLIORE)
for j = 1:max(size(u))
    sum = zeros(2,1);
    % Secondo ciclo: calcolo della combinazione lineare delle componenti
    % polinomiali di Bernstein(da 0 a N-1), con i punti di controllo
    %(la combinazione tra componente polinomiale N e punto N è calcolata all'esterno del ciclo) 
    for i = 1:n
        B = nchoosek(n,i-1)*((u(j))^(i-1))*((1-(u(j)))^(n-i+1)); %calcolo del valore polinomiale di Bernstein 
        sum = sum + B*P(:,i); %prodotto del valore polinomiale con il punto di controllo i-esimo
    end
    B = ((u(j))^(n)); % calcola l'ultima componente polinomiale di Bernstein 
    sum = sum + B*P(:,n); % effettua la combinazione lineare della componente polinomiale N-esima
    % con l'omologo punto di controllo e la somma al polinomio
    A(:,index) = sum; %matrice che contiene i punti della curva come vettori colonna:
    % ogni colonna rappresenta la valutazione della posizione del punto (x,y) sulla curva
    % all'istante t
    index = index+1;
end
x = A(1,:);
y = A(2,:);

tempo = toc;
%% Plotting dei risultati

%plot dei punti di controllo e della poligonale associata
plot(app.UIAxes,P(1,:),P(2,:),'ko','MarkerSize',3,'DisplayName','Punti di controllo'); hold(app.UIAxes,'on'); axis(app.UIAxes,'equal');
plot(app.UIAxes,P(1,:),P(2,:),'--k','DisplayName','Poligono di controllo'); 

%plot della curva di Bezier mediante interpolazione lineare

plot(app.UIAxes,x,y,'g','DisplayName','Curva di Bezier');

% stampa della legenda senza duplicati in visualizzazione (mediante la
% funzione di libreria legendUnq())
legend(legendUnq(app.UIAxes));
end

