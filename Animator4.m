function Animator4(Th, tt)
% Author: Mansour Torabi
% Email: smtoraabi@ymail.com
%%
try
    filename = 'Pic/Anim4.gif';
    Hf = figure;
    set(Hf,'color',[1 1 1]);
    
    dx = Th(1,1); th1 = Th(1,2); th2 = Th(1,3);
    
    L1 = 2; L2 = 2;
    x11 = 5 + dx; y11 = 5;
    x12 = x11+ L1*sin(th1);
    y12 = y11 -L1*cos(th1);
    H1 = line([x11 x12],[y11 y12],'linewidth',2);  hold on;
    plot([2 8],[y11 y11],'--k');
    
    H0 = plot(x11, y11, 's', 'markersize', 20, ...
        'linewidth', 2, 'color', [0, 0.8, 0], 'markerfacecolor', [0, 0.8, 0]);
    
    H1m = plot(x12, y12, 'O', 'markersize', 12, ...
        'linewidth', 2, 'color', 'r', 'markerfacecolor', 'r');
    
    x21 = x12;
    y21 = y12;
    x22 = x21+ L2*sin(th2);
    y22 = y21 -L2*cos(th2);
    H2 = line([x21 x22],[y21 y22],'linewidth',2);
    H2m = plot(x22, y22, 'O', 'markersize', 12, ...
        'linewidth', 2, 'color', 'r', 'markerfacecolor', 'r');
    
    
    axis([0 10 0 6]); box off; axis equal
    set(gca,'xlim',[1 9],'ylim',[0 9],'xtick',[], 'ytick', [])
    
    Txt = sprintf('Time: %0.2f sec', tt(1));
    Htxt = text(3.5, 8, Txt);
    set(Htxt, 'fontsize', 16, 'fontweight', 'bold');

    frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);
    imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime',0.05);
    
    for i = 1:size(Th,1)
        pause(0.00001)
        dx = Th(i,1); th1 = Th(i,2); th2 = Th(i,3);
        %% Link 1
        x11 = 5 + dx; y11 = 5;
        x12 = x11+ L1*sin(th1);
        y12 = y11 -L1*cos(th1);
        %% Link 2
        x21 = x12;
        y21 = y12;
        
        x22 = x21+ L2*sin(th2);
        y22 = y21 -L2*cos(th2);
        %%
        set(H0, 'XData', x11, 'YData', y11);
        set(H1,'XData',[x11 x12],'YData',[y11 y12]);
        set(H2,'XData',[x21 x22],'YData',[y21 y22]);
        set(H1m,'XData',x12,'YData',y12);
        set(H2m,'XData',x22,'YData',y22);
        
        Txt = sprintf('Time: %0.2f sec', tt(i));
        set(Htxt, 'string', Txt);

        
        frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);
        imwrite(imind,cm,filename,'gif', 'WriteMode','append', 'DelayTime',0.05);
        
    end
catch
    fprintf('You Forced to stop Animation!!\n\n')
end




