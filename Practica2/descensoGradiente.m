function [w, E_hist] = descensoGradiente(x, w, Y, alpha, num_iter, fig)

%% Modificar
E_hist = zeros(1,num_iter); % inicializar a 0's el vector E_hist para almacenar el error iterativamente

w_old = ; % inicializa a 0's el vector donde guardaremos en cada iteracion los pesos antiguos 
eps = 1e-10; % elige un valor de epsilon para que el bucle se pare: criterio de parada % 1e-5 en validacion

%% No Modificar

refresh_rate = num_iter/10; % solo actualiza la figura  cada 10 pasos
if fig, figure, end % crea una nueva figura si se quieren los plots

% bucle de iteraciones
for i = 1:num_iter
    E_hist(i) = calculaError(x,w,Y);  % calcula el error cuadratico medio para estos pesos
    
    %% Modificar
    
    w_old(:,i) = w;  % guardamos el valor actual de los pesos (solo lo usaremos para el plot)
    
    y = ;  % calcula el output o prediccion de la nuestra red
    e = ;  % calcula el error RELATIVO entre predicci�n y valor real
    grad_E = mean( repmat(e,size(x,1),1) .* x ,2);  % calcula el gradiente del error
    w = ;  % actualiza el vector de los pesos con los nuevos valores (pesos del paso anterior - alpha * media de la derivada del error)
    
    if norm(grad_E) < eps % salir del bucle si la norma del gradiente es menor que epsilon % criterio de parada
        disp(['Parado en la iteracion: ' num2str(i)])
        break
    end
    
    %% No modificar (excepto el hecho de descomentar parte del codigo cuando tratemos el conjunto de validacion)
    % plots
    if fig && mod(i,refresh_rate)==0        
        subplot(2,2,1)
        hold off
        plot(x(2,:), Y, 'ro', 'linestyle', 'none', 'markersize', 8)
        hold on
        set(gca, 'fontsize', 10)
        xlabel('x'), ylabel('Y')
        plot(x(2,:),y, 'b--', 'linewidth', 1)
        subplot(2,2,2)
        hold on
        plot_2Dtimeseries(w_old(1,1:i), w_old(2,1:i),1:i)
        if i==num_iter
        plot(w_old(1,i),w_old(2,i),'k+')
        end
        grid on
        xlabel('w_0'), ylabel('w_1')
        set(gca, 'fontsize', 10)
        subplot(2,2,3)
        plot(E_hist(1:i),'linewidth',2)
        set(gca, 'fontsize', 10,'xscale','log')
        xlabel('iter de aprendizaje [log]'), ylabel('error de aprendizaje')
        xlim([1 num_iter])  
%         subplot(2,2,4)
%         plot(E_val_hist(1:i),'linewidth',2)
%         set(gca, 'fontsize', 10,'xscale','log')
%         xlabel('iter de aprendizaje [log]'), ylabel('error de validación')
%         xlim([1 num_iter])
        drawnow
    end
end