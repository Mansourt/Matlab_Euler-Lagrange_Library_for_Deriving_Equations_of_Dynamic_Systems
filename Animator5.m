function Animator5(Th, tt)
% Author: Mansour Torabi
% Email: smtoraabi@ymail.com
%%
try
    filename = 'Pic/Anim5.gif';
    Hf = figure;
    set(Hf,'color',[1 1 1]);
    
    dx1 = Th(1,1); dx2 = Th(1,2); th1 = Th(1,3); th2 = Th(1,4);
    RotFcn = @(X,th)[cos(th), -sin(th);  sin(th), cos(th)]*X;

    %% Link 1
    l1 = 2; l2 = 2; 
    x11 = 5; y11 = 8;

    L1 = l1+dx1; L2 = l2+dx2;
    x12 = x11 + L1*sin(th1);
    y12 = y11 - L1*cos(th1);
    
    a = 0.1; t0 = linspace(0,L1,1e3);
    x = a*sin(100/L1*t0); y = - t0;
    XX = [x;y];    
    Xr1 = RotFcn(XX, th1) + repmat([x11; y11],1,length(t0));    
    H1 = line([x11 Xr1(1,:)],[y11 Xr1(2,:)],'linewidth',1.5);
    hold on;
    H0 = plot(x11, y11, 's', 'markersize', 20, ...
        'linewidth', 2, 'color', [0, 0.8, 0], 'markerfacecolor', [0, 0.8, 0]);
    
    H1m = plot(x12, y12, 'O', 'markersize', 12, ...
        'linewidth', 2, 'color', 'r', 'markerfacecolor', 'r');
    

    %% Link 2 

    x21 = x12;
    y21 = y12;

    x22 = x21 + L2*sin(th2);
    y22 = y21 - L2*cos(th2);
    
    a = 0.1; t0 = linspace(0,L2,1e3);
    x = a*sin(100/L2*t0); y = - t0;
    XX = [x;y];    
    Xr2 = RotFcn(XX, th2) + repmat([x21; y21],1,length(t0));    
    H2 = line([x21 Xr2(1,:)],[y21 Xr2(2,:)],'linewidth',1.5);

    H2m = plot(x22, y22, 'O', 'markersize', 12, ...
        'linewidth', 2, 'color', 'r', 'markerfacecolor', 'r');
    
    
    axis([0 10 0 6]); box off; axis equal
    set(gca,'xlim',[1 9],'ylim',[0 9],'xtick',[], 'ytick', [])

    %% Text
    Txt = sprintf('Time: %0.2f sec', tt(1));
    Htxt = text(3.5, 9, Txt);
    set(Htxt, 'fontsize', 16, 'fontweight', 'bold');

    frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);
    imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime',0.05);
    
    for i = 1:size(Th,1)
        pause(0.00001)
        dx1 = Th(i,1); dx2 = Th(i,2); th1 = Th(i,3); th2 = Th(i,4);
        %% Link 1
        L1 = l1+dx1; L2 = l2+dx2;
        x12 = x11 + L1*sin(th1);
        y12 = y11 - L1*cos(th1);
        
        a = 0.1; t0 = linspace(0,L1,1e3);
        x = a*sin(100/L1*t0); y = - t0;
        XX = [x;y];    
        Xr1 = RotFcn(XX, th1) + repmat([x11; y11],1,length(t0));
        %% Link 2
        x21 = x12;
        y21 = y12;

        x22 = x21 + L2*sin(th2);
        y22 = y21 - L2*cos(th2);
        
        a = 0.1; t0 = linspace(0, L2,1e3);
        x = a*sin(100/L2*t0); y = - t0;
        XX = [x;y];
        Xr2 = RotFcn(XX, th2)+repmat([x21;y21],1,length(t0));

        %%
        set(H0, 'XData', x11, 'YData', y11);
        set(H1,'XData',Xr1(1,:),'YData',Xr1(2,:))

        %% 
        set(H2,'XData',Xr2(1,:),'YData',Xr2(2,:))

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




