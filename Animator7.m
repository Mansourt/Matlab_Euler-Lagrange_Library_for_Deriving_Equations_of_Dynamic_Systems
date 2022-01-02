function Animator7(Th, tt,Param)
% Author: Mansour Torabi
% Email: smtoraabi@ymail.com
%%
try
    filename = 'Pic/Anim7.gif';
    Hf = figure;
    set(Hf,'color',[1 1 1]);
    
    th0 = Th(1,1); ths = Th(1,2); dx = Th(1,3);
    R0 = Param(1); r0 = Param(2); l0 = Param(3);

    RotFcn = @(X,th)[cos(th), -sin(th);  sin(th), cos(th)]*X;

    %% Main Param

    R = 3.5; r = r0*R/R0; l = l0*R/R0;
    R_od = R-r;

    xRo = 5; yRo = 7;

    %% SemiCircle and Disc

    aa = linspace(-pi,0,100);
    xR = R*cos(aa) + xRo;
    yR = R*sin(aa) + yRo;
    plot(xR, yR, 'LineWidth',2, 'Color',[0,0.6,0]);
    hold on;

    P_disc = [xRo, yRo] + R_od*[sin(th0), -cos(th0)];
    Hod = plot(P_disc(1), P_disc(2), 'ro');
    
    aa = linspace(-pi,pi,100);
    xr = r*cos(aa) + P_disc(1);
    yr = r*sin(aa) + P_disc(2);

    Hd = plot(xr, yr, 'LineWidth',5, 'Color','r');
    
    % Line inside disc
    xld = [0, 0]; yld = [0, -r];
    XXld = [xld;yld];
    alpha = R_od * th0 / r;
    Xld = RotFcn(XXld, alpha) + repmat([P_disc(1); P_disc(2)],1,length(xld)); 

    Hld = plot(Xld(1,:), Xld(2,:), 'r','LineWidth',2);
    %% Spring and Mass
    Ls = l + dx;

    a = 0.1; t0 = linspace(0,Ls,1e3);
    x = a*sin(100/Ls*t0); y = - t0;
    XX = [x;y];    
    Xrs = RotFcn(XX, ths) + repmat([P_disc(1); P_disc(2)],1,length(t0)); 
    Hs = line([P_disc(1), Xrs(1,:)],[P_disc(2), Xrs(2,:)],'linewidth',1.2);

    Pm = R_od*[sin(th0), -cos(th0)] + Ls*[sin(ths), -cos(ths)] + [xRo, yRo];
    Hm = plot(Pm(1), Pm(2), 'O', 'markersize', 12, ...
        'linewidth', 2, 'color', 'r', 'markerfacecolor', 'r');
    %% Axis

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
        th0 = Th(i,1); ths = Th(i,2); dx = Th(i,3);
        %% SemiCircle and Disc
        
        P_disc = [xRo, yRo] + R_od*[sin(th0), -cos(th0)];
        set(Hod, 'xdata',P_disc(1), 'ydata', P_disc(2))
        
        aa = linspace(-pi,pi,100);
        xr = r*cos(aa) + P_disc(1);
        yr = r*sin(aa) + P_disc(2);
        
        set(Hd, 'xdata',xr, 'ydata', yr);
        
        % Line inside disc
        xld = [0, 0]; yld = [0, -r];
        XXld = [xld;yld];
        alpha = R_od * th0 / r;
        Xld = RotFcn(XXld, alpha) + repmat([P_disc(1); P_disc(2)],1,length(xld)); 
        set(Hld, 'xdata', Xld(1,:), 'ydata', Xld(2,:));
        
        %% Spring and Mass
        Ls = l + dx;

        a = 0.1; t0 = linspace(0,Ls,1e3);
        x = a*sin(100/Ls*t0); y = - t0;
        XX = [x;y];
        Xrs = RotFcn(XX, ths) + repmat([P_disc(1); P_disc(2)],1,length(t0));

        set(Hs, 'xdata', Xrs(1,:), 'ydata', Xrs(2,:));

        Pm = R_od*[sin(th0), -cos(th0)] + Ls*[sin(ths), -cos(ths)]  + [xRo, yRo];
        set(Hm,'xdata', Pm(1), 'ydata', Pm(2));

        %%

        Txt = sprintf('Time: %0.2f sec', tt(i));
        set(Htxt, 'string', Txt);


        frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);
        imwrite(imind,cm,filename,'gif', 'WriteMode','append', 'DelayTime',0.05);

    end
catch
    fprintf('You Forced to stop Animation!!\n\n')
end




