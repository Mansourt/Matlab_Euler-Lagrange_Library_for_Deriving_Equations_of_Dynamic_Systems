function Animator3(X)

% Author: Mansour Torabi
% Email: smtoraabi@ymail.com

%%
try
    filename = 'Anim3.gif';
    Hf = figure;
    
    th1 = X(1,1); dx = X(1,2);
    
    L1  = 3;
    x11 = 5 + dx; y11 = 5;
    
    x12 = x11 + L1*sin(th1);
    y12 = y11 - L1*cos(th1);
    H1  = line([x11 x12],[y11 y12],'linewidth',2);
    set(gca,'xlim',[3 7],'ylim',[3 6])
    axis equal
    
    hold on;
    H2 = plot(x11, y11, 's', 'markersize', 14, ...
        'linewidth', 3, 'color', [0, 0.5, 0], 'markerfacecolor', [0, 0.5, 0]);
    
    H3 = plot(x12, y12, 'O', 'markersize', 14, ...
        'linewidth', 2, 'color', 'r', 'markerfacecolor','r');
    plot([4 6],[y11 y11],'--k');
    box on; axis equal
    set(gca,'xlim',[3 7],'ylim',[3 6])
    
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
        
        %%
        set(H1,'XData',[x11 x12],'YData', [y11 y12])
        set(H2,'XData', x11, 'YData', y11);
        set(H3,'XData', x12, 'YData', y12);
        
        frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);
        imwrite(imind,cm,filename,'gif', 'WriteMode','append', 'DelayTime',0.05);
        
    end
catch
    fprintf('You Forced to stop Animation!!\n\n')
end




