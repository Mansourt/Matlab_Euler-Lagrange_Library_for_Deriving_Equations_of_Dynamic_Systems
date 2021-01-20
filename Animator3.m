function Animator3(X, tt)

% Author: Mansour Torabi
% Email: smtoraabi@ymail.com

%%
try
    filename = 'Pic/Anim3.gif';
    Hf = figure;
    set(Hf,'color',[1 1 1]);
    
    th1 = X(1,1); dx = X(1,2);
    
    L1 = 1; % length of pendulum
    L2 = 1; % length of spring
    
    x11 = 5 + dx; y11 = 5;
    
    x12 = x11 + L1*sin(th1);
    y12 = y11 - L1*cos(th1);
    H1  = line([x11 x12],[y11 y12],'linewidth',2);
    hold on;
    a = 0.1; t0 = linspace(0,L2+dx,1e3);
    xs = t0; ys = 5+a*sin(100/(L2+dx)*t0);
    H2 = plot(xs+(5-L2), ys);
    
    
    hold on;
    H3 = plot(x11, y11, 's', 'markersize', 20, ...
        'linewidth', 2, 'color', [0, 0.8, 0], 'markerfacecolor', [0, 0.8, 0]);
    
    H4 = plot(x12, y12, 'O', 'markersize', 14, ...
        'linewidth', 2, 'color', 'r', 'markerfacecolor','r');
    plot([4 6],[y11 y11],'--k');
    

    box off; axis equal
    set(gca,'xlim',[3 7],'ylim',[3 6],'xtick',[], 'ytick', [])
    
    Txt = sprintf('Time: %0.2f sec', tt(1));
    Htxt = text(3.5, 6, Txt);
    set(Htxt, 'fontsize', 16, 'fontweight', 'bold');
    
    frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);
    imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime',0.05);
    
    for i = 1:size(X,1)
        pause(0.00001)
        th1 = X(i,1); dx = X(i,2);
        %% Spring
        L1  = 1;
        x11 = 5 + dx; y11 = 5;
        
        x12 = x11 + L1*sin(th1);
        y12 = y11 - L1*cos(th1);
        
        a = 0.1; t0 = linspace(0,L2+dx,1e3);
        xs = t0; ys = 5+a*sin(100/(L2+dx)*t0);

        %%
        set(H1,'XData',[x11 x12],'YData', [y11 y12])
        set(H2, 'XData', xs +(5-L2), 'YData', ys);
        set(H3,'XData', x11, 'YData', y11);
        set(H4,'XData', x12, 'YData', y12);
        
        Txt = sprintf('Time: %0.2f sec', tt(i));
        set(Htxt, 'string', Txt);

        frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);
        imwrite(imind,cm,filename,'gif', 'WriteMode','append', 'DelayTime',0.05);
        
    end
catch
    fprintf('You Forced to stop Animation!!\n\n')
end




