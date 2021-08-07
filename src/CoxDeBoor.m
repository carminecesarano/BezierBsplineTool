function [N]= CoxDeBoor(t,p,u,i)
%caso base (interpolazione di grado 0 - partendo da 1 
%(perchè MATLAB non definisce la posizione 0 degli arrays)

if(p==1) %definizione funzioni di base al grado 0
    if((u>=t(i)) && (u<=t(i+1))) %se appartiene al knot span
        N=1; %costantemente 1
    else
        N=0; %costantemente 0
    end;
else
    %calcolo del termine sinistro della formula ricorsiva
    a=t(i+p-1)-t(i);
    N1=0;
    if(a~=0)
        n=CoxDeBoor(t,p-1,u,i); %chiamata ricorsiva decrementando il grado p delle
                                %funzioni di base N(i,p-1)
        N1=((u-t(i))*n)/a; %termine sinistro della formula ricorsiva
    end;
    
    %calcolo del termine destro della formula ricorsiva
    a=t(i+p)-t(i+1);
    N2=0;
    if(a~=0)
        n=CoxDeBoor(t,p-1,u,i+1); %chiamata ricorsiva decrementando il grado p delle
                                  %funzioni di base N(i,p-1)
        N2=((t(i+p)-u)*n)/a; %termine destro della formula ricorsiva
    end;
    
    N=N1+N2; %somma dei termini
end