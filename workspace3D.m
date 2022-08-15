clear;
clc;
close all;

a1 = -0.12; d1 = 0.46; alpha1 = -pi/2; th1 = 0;
a2 = 0.67 ; d2 = 0   ; alpha2 = 0    ; th2 = -pi/4;
a3 = 0    ; d3 = 0   ; alpha3 = -pi/2; th3 = 3*pi/4;
a4 = 0    ; d4 = 0.7 ; alpha4 = pi/2 ; th4 = 0;


% k = cos(alpha2);
% phi = pi/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Limits of th2, th3
th2_min = -90*pi/180;
th2_max = 180*pi/180;
th3_min = -90*pi/180;
th3_max = 180*pi/180;
th1_min = -pi;
th1_max = pi;

%Homogenous Transformation Matrix
for th1 = [th1_min:100*pi/180:th1_max]
for th2 = [th2_min:10*pi/180:th2_max]
for th3 = [th3_min:10*pi/180:th3_max]
A01 = [cos(th1) -cos(alpha1)*sin(th1) sin(alpha1)*sin(th1) a1*cos(th1);
       sin(th1) cos(alpha1)*cos(th1) -sin(alpha1)*cos(th1) a1*sin(th1);
       0 sin(alpha1) cos(alpha1) d1;
       0 0 0 1];
A12 = [cos(th2) -cos(alpha2)*sin(th2) sin(alpha2)*sin(th2) a2*cos(th2);
       sin(th2) cos(alpha2)*cos(th2) -sin(alpha2)*cos(th2) a2*sin(th2);
       0 sin(alpha2) cos(alpha2) d2;
       0 0 0 1];
A23 = [cos(th3) -cos(alpha3)*sin(th3) sin(alpha3)*sin(th3) a3*cos(th3);
       sin(th3) cos(alpha3)*cos(th3) -sin(alpha3)*cos(th3) a3*sin(th3);
       0 sin(alpha3) cos(alpha3) d3;
       0 0 0 1];
A34 = [cos(th4) -cos(alpha4)*sin(th4) sin(alpha4)*sin(th4) a4*cos(th4);
       sin(th4) cos(alpha4)*cos(th4) -sin(alpha4)*cos(th4) a4*sin(th4);
       0 sin(alpha4) cos(alpha4) d4;
       0 0 0 1];

A04=A01*A12*A23*A34;
X=A04(1,4);
Y=A04(2,4);
Z=A04(3,4);
hold 'all'
plot3(X,Y,Z,'xr')
% plot(X,Y,'xr')
end
end
end
