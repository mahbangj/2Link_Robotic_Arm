clear;
clc;
%% 
figure()
h = plot3(0,0,0);p = get(h,'Parent');
axis vis3d;grid on;
point1.x = 0   ;point1.y = 0;   point1.z = 0;
point2.x = 0   ;point2.y = 0;   point2.z = 22;
point3.x = 22  ;point3.y = 0;   point3.z = 22+24;
point4.x = 22  ;point4.y = 0;   point4.z = 22+24+67;
point5.x = 22  ;point5.y = 0;   point5.z = 22+24+67+70;
%theta1 = 0:30/100:30;
%theta2 = 0:45/100:45;
l  = line([point1.x, point2.x],[point1.y,point2.y],[point1.z,point2.z],'Color','r','LineWidth',4);
l1 = line([point2.x, point3.x],[point2.y,point3.y],[point2.z,point3.z],'Color','b','LineWidth',4);
l2 = line([point3.x, point4.x],[point3.y,point4.y],[point3.z,point4.z],'Color','g','LineWidth',4);
l3 = line([point4.x, point5.x],[point4.y,point5.y],[point4.z,point5.z],'Color','k','LineWidth',4);

theta1 = -180:1:180;      %360
theta2 = -90:1:180;      %270
theta3=  -90:1:180;      %270
theta4=  0;

for k = 1:360 
% because we have different range of angulars to make a complete circle we
% used this
if (k>250)
    if k<313
    y=250;
    end
elseif k>313
    y=250;
    z=313;
else
    y=k;
    z=k;
end
T1=RobotConv(theta1(k), 46, 0, 0);
T2=RobotConv(theta2(y), 46, 12, -90);
T3=RobotConv(theta3(z), 46, 67, 0);
T4=RobotConv(theta4,70,0,-90);

p0 = [0 0 0];
p1 = RobotPosition(T1);
p2 = RobotPosition(T1*T2);
p3 = RobotPosition(T1*T2*T3);
p4 = RobotPosition(T1*T2*T3*T4);

p1=p1+p0;
p2=p2+p1+p0;
p3=p3+p2+p1+p0;
p4=p4+p3+p2+p1+p0;

point1.x=p0(1);
point2.x=p1(1);
point3.x=p2(1);
point4.x=p3(1);
point5.x=p4(1);

point1.y=p0(2);
point2.y=p1(2);
point3.y=p2(2);
point4.y=p3(2);
point5.y=p4(2);

point1.z=p0(3);
point2.z=p1(3);
point3.z=p2(3);
point4.z=p3(3);
point5.z=p4(3);


set(l, 'ZData',[point1.z,point2.z],'YData',[point1.y,point2.y],'XData',[point1.x,point2.x]);
set(l1,'ZData',[point2.z,point3.z],'YData',[point2.y,point3.y],'XData',[point2.x,point3.x]);
set(l2,'ZData',[point3.z,point4.z],'YData',[point3.y,point4.y],'XData',[point3.x,point4.x]);
set(l3,'ZData',[point4.z,point5.z],'YData',[point4.y,point5.y],'XData',[point4.x,point5.x]);


hold on;
figure(1)
filename = 'Day02_Path.gif';
plot3(point5.x,point5.y,point5.z,'xk');
pause(0.1);

frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if k == 1;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','WriteMode','append');
      end

end


function P = RobotPosition(T)
    x = T(1,4);
    y = T(2,4);
    z = T(3,4);
    
    P = [x y z];
   
end

function T = RobotConv(theta,d,a,alpha)
    rad = pi/180;
    theta=theta*rad;
    alpha=alpha*rad;
    T=[cos(theta) -sin(theta) 0 a;
        sin(theta)*cos(alpha) cos(theta)*cos(alpha) -sin(alpha) -sin(alpha)*d;
        sin(theta)*sin(alpha) cos(theta)*sin(alpha) cos(alpha) cos(alpha)*d;
        0 0 0 1];

end
