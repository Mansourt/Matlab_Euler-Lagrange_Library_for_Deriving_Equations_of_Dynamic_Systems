function Animator6(Th, tt,Param)
% Author: Mansour Torabi
% Email: smtoraabi@ymail.com
%%
try
    filename = 'Pic/Anim6.gif';
    Hf = figure;
    set(Hf,'color',[1 1 1]);
    
    th1 = Th(1,1); th2 = Th(1,2);
    l0 = Param(1); l1 = Param(2); l2 = Param(3);

    RotFcn = @(X,th)[cos(th), -sin(th);  sin(th), cos(th)]*X;

    %% Link 1

    L1 = 2; L2 = L1*l2/l1; L0 = L1*l0/l1;

    x11 = 3; y11 = 5;
    x12 = x11 + L1*sin(th1);
    y12 = y11 - L1*cos(th1);

    H1 = line([x11 x12],[y11 y12],'linewidth',2);  hold on;

    hold on;
    H01 = plot(x11, y11, 's', 'markersize', 20, ...
        'linewidth', 2, 'color', [0, 0.8, 0], 'markerfacecolor', [0, 0.8, 0]);
    
    H1m = plot(x12, y12, 'O', 'markersize', 12, ...
        'linewidth', 2, 'color', 'r', 'markerfacecolor', 'r');
    
    
    %% Link 2 

    x21 = x11 + L0; y21 = 5;

    x22 = x21 + L2*sin(th2);
    y22 = y21 - L2*cos(th2);
    
    H2 = line([x21 x22],[y21 y22],'linewidth',2);  hold on;
    H02 = plot(x21, y21, 's', 'markersize', 20, ...
        'linewidth', 2, 'color', [0, 0.8, 0], 'markerfacecolor', [0, 0.8, 0]);

    H2m = plot(x22, y22, 'O', 'markersize', 12, ...
        'linewidth', 2, 'color', 'r', 'markerfacecolor', 'r');
    
    %% Spring

    dXX = L0 + L2*sin(th2) - L1*sin(th1);
    dYY = L1*cos(th1) - L2*cos(th2);
    
    Ls = (dXX^2 + dYY^2)^0.5;
    ths = atan2(dYY,dXX);

    a = 0.1; t0 = linspace(0,Ls,1e3);
    x = a*sin(100/Ls*t0); y = - t0;
    XX = [x;y];    
    Xrs = RotFcn(XX, ths+pi/2) + repmat([x12; y12],1,length(t0));    
    Hs = line([x12 Xrs(1,:)],[y12 Xrs(2,:)],'linewidth',1.2);
    %%

    box off; axis equal
    set(gca,'xlim',[0 10],'ylim',[0 9],'xtick',[], 'ytick', [])

    %% Text
    Txt = sprintf('Time: %0.2f sec', tt(1));
    Htxt = text(3.5, 9, Txt);
    set(Htxt, 'fontsize', 16, 'fontweight', 'bold');

    frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);
    imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime',0.05);
    
    for i = 1:size(Th,1)
        pause(0.00001)
        th1 = Th(i,1); th2 = Th(i,2);
        %% Link 1
        x12 = x11 + L1*sin(th1);
        y12 = y11 - L1*cos(th1);

        set(H1, 'XData',[x11 x12],'YData', [y11 y12])
        set(H1m,'XData',x12,'YData',y12);

        %% Link 2
        x22 = x21 + L2*sin(th2);
        y22 = y21 - L2*cos(th2);

        set(H2, 'XData',[x21 x22],'YData',[y21 y22])     
        set(H2m,'XData',x22,'YData',y22);

        %% Spring
        dXX = L0 + L2*sin(th2) - L1*sin(th1);
        dYY = L1*cos(th1) - L2*cos(th2);
        
        Ls = (dXX^2 + dYY^2)^0.5;
        ths = atan2(dYY,dXX);
    
        a = 0.1; t0 = linspace(0,Ls,1e3);
        x = a*sin(100/Ls*t0); y = - t0;
        XX = [x;y];    
        Xrs = RotFcn(XX, ths+pi/2) + repmat([x12; y12],1,length(t0));    

        set(Hs,'XData',Xrs(1,:),'YData',Xrs(2,:))
        %%
        
        

        Txt = sprintf('Time: %0.2f sec', tt(i));
        set(Htxt, 'string', Txt);

        
        frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);
        imwrite(imind,cm,filename,'gif', 'WriteMode','append', 'DelayTime',0.05);
        
    end
catch
    fprintf('You Forced to stop Animation!!\n\n')
end




