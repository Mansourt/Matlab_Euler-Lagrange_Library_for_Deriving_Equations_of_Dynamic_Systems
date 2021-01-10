function Animator2(X)

% Author: Mansour Torabi
% Email: smtoraabi@ymail.com
%%
try
    filename = 'Anim2.gif';
    Hf = figure;
    
    th1 = X(1,1); x = X(1,2);
    
    L1  = 1;
    x11 = 5; y11 = 5;
    x12 = x11+ (L1+x)*sin(th1);
    y12 = y11 -(L1+x)*cos(th1);
    H1  = line([x11 x12],[y11 y12],'linewidth',2);
    hold on;
    H2 = plot(x12, y12, 'O', 'markersize', 8, ...
        'linewidth', 3, 'color', 'r', 'markerfacecolor', 'r');
    
    
    axis([0 10 0 6]); box on; axis equal
    set(gca,'xlim',[1 9],'ylim',[0 9])
    
    frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);    
    imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime',0.05);
    
    for i = 1:size(X,1)
        pause(0.0001)
        th1 = X(i,1); x = X(i,2);
        %% Link 1
        x11 = 5; y11 = 5;
        x12 = x11+ (L1+x)*sin(th1);
        y12 = y11 -(L1+x)*cos(th1);
        %%
        set(H1,'XData',[x11 x12],'YData',[y11 y12])
        set(H2,'XData', x12, 'YData', y12);
        
        frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);
        
        imwrite(imind,cm,filename,'gif', 'WriteMode','append', 'DelayTime',0.05);
              
    end
catch
    fprintf('You Forced to stop Animation!!\n\n')
end




