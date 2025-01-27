function [time, v, sp_time, sp_count] = integrate_and_fire(dt,tot_time, VL, Vth, tau, R, tau_rp, I, Isyn)

% Esta funcion simula un modelo IF neuronal
% Calculando oel rate de spikes en el tiempo podremos visualizar el output
% de las neuronas de diferentes maneras:
%           1. Raster Plot (spike over time) - cada punto es un spike
%           2. Membrane Potential Plot (V de la membrana en funcion del tiempo)  
% Tambien podremos visualizar el input dada una corriente o un tren de
% spikes

% I sera la corriente de input, R la resistencia de la membrana
% Isyn sera el input presinaptico de las neuronas vecinas (discreto)
% es decir Itotal = I + Isyn.
% dt es el paso de integracion en segundos
% tau_rp es el tiempo refractario en segundos
% tot_time es el tiempo de simulacion en segundos!!!
total_time = 1;
max_steps = total_time /dt; %maximo numero de pasos donde cada paso es definido por dt !
time = 0:dt:tot_time-dt; % vector de tiempos, el eje x en los plots

%Potencial de membrana
v0 = VL; % valor inicial del potencial
v = zeros(1,max_steps); % vector del potencial de membrana
v(1) = v0; % inicializa el primer elemento del vector del potencial, condicion inicial

% Propiedades de las spikes
sp_count = 0; % para contar el numero de spikes generados
sp_time = zeros(1,max_steps); % inicializa un vector de tiempos, para guardar el tiempo en que se genera cada spike
last_spike = -tau_rp; % Inicializa la ultima spike

if isempty(Isyn), Isyn = zeros(1,max_steps); end % por compatibilidad

% Ahora podemos simular la dinamica de un modelo IF usando un loop.
% La descripcion del potencial de membrana deberia incluir: reposo, input,
% umbral, spike, periodo refractario.

%1.Necessitamos estar por encima del periodo de tiempo refractario para
%poder 'spike' de nuevo
for n=2:max_steps  % como ya hemos definido v(1), empezamos el bucle en el segundo paso
    if time(n) - last_spike > tau_rp
        % 2. Describe la dinamica del potencial de membrana (como en las instrucciones)
        F = (1/tau)*(VL - v(n-1) + R*(I + Isyn(n-1)));% ! la equation differential
        v(n) = v(n-1)+dt*F; % ! la solution particular
    else
        % 3. Describe lo que pasa en reposo
        v(n) = v0; % !
    end
    % 4. Describe las condiciones necesarias para el mecanismo de spikes
    if v(n) >= Vth  %!cumplir
        sp_count = sp_count+1; % actualiza el contador de spikes !
        sp_time(sp_count) = time(n); % guarda el tiempo (en segundos) del spike !
        last_spike = n*dt; % actualizado para calcular el periodo refractario
        v(n) = Vth;
        %v(n) = VL; ??
    end
end

% elimina los elementos de sp_time que son iguales a 0 (se usa logical indexing, puedes aprender a usarlo leyendo el help de matlab)
sp_time(sp_time==0) = [];
