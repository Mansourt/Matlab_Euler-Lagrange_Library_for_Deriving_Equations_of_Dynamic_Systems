function Animator2(X)

% Author: Mansour Torabi
% Email: smtoraabi@ymail.com
%%
try
    filename = 'Anim2.gif';
    Hf = figure;
    
    th1 = X(1,1); dx = X(1,2);
    
    L1  = 1;
    x11 = 5; y11 = 5;
    
    x12 = x11+ (L1+dx)*sin(th1);
    y12 = y11 -(L1+dx)*cos(th1);
    %H1  = line([x11 x12],[y11 y12],'linewidth',2);
    
    a = 0.1; tt = linspace(0,(L1+dx),1e3);
    x = a*sin(100/(L1+dx)*tt); y = - tt;
    XX = [x;y];
    Rot = @(X,th)[cos(th), -sin(th);  sin(th), cos(th)]*X;
    Xr = Rot(XX, th1)+repmat([x11;y11],1,length(tt));
    H1 = plot(Xr(1,:), Xr(2,:));
    axis equal

    hold on;
    H2 = plot(x12, y12, 'O', 'markersize', 14, ...
        'linewidth', 3, 'color', 'r', 'markerfacecolor', 'r');
    
    
    axis([0 10 0 6]); box on; axis equal
    set(gca,'xlim',[2 8],'ylim',[0 6])
    
    frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);    
    imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime',0.05);
    
    for i = 1:size(X,1)
        pause(0.00001)
        th1 = X(i,1); dx = X(i,2);
        %% Spring
        x11 = 5; y11 = 5;
        x12 = x11+ (L1+dx)*sin(th1);
        y12 = y11 -(L1+dx)*cos(th1);
        
        a = 0.1; tt = linspace(0,(L1+dx),1e3);
        x = a*sin(100/(L1+dx)*tt); y = - tt;
        XX = [x;y];
        Rot = @(X,th)[cos(th), -sin(th);  sin(th), cos(th)]*X;
        Xr = Rot(XX, th1)+repmat([x11;y11],1,length(tt));
        %%
        set(H1,'XData',Xr(1,:),'YData',Xr(2,:))
        set(H2,'XData', x12, 'YData', y12);
        
        frame = getframe(Hf); im = frame2im(frame); [imind,cm] = rgb2ind(im,256);
        
        imwrite(imind,cm,filename,'gif', 'WriteMode','append', 'DelayTime',0.05);
              
    end
catch
    fprintf('You Forced to stop Animation!!\n\n')
end




