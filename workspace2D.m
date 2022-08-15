clc;
clear;
close all;
% D-H Parameters
a1 = -0.12; d1 = 0.46; alpha1 = -pi/2  ; theta1 = 0;
a2 = 0.67 ; d2 = 0   ; alpha2 = 0      ; theta2 = -pi/4;
a3 = 0    ; d3 = 0   ; alpha3 = -pi/2  ; theta3 = 3*pi/4;
a4 = 0    ; d4 = 0.7 ; alpha4 = pi/2   ; theta4 = 0;


% Axis Properties
%points
X=[0 0 0.22 0.22 0.22];
Z=[0 0.22 0.22+0.24 0.22+0.24+0.67 0.22+0.24+0.67+0.70];

% Iteration of th2,th3 within maximum and minimum limits
% for theta1_0=  -180:50:180
for theta2_0 = -90:10:180
for theta3_0 = -90:10:180
% theta1=theta1_0*pi/180;
theta2=theta2_0*pi/180;
theta3=theta3_0*pi/180;
A01 = [cos(theta1), -cos(alpha1)*sin(theta1), sin(alpha1)*sin(theta1),a1*cos(theta1);
       sin(theta1), cos(alpha1)*cos(theta1), -sin(alpha1)*cos(theta1),a1*sin(theta1);
       0, sin(alpha1), cos(alpha1),d1;
       0, 0, 0, 1 ];
A12 = [cos(theta2), -cos(alpha2)*sin(theta2), sin(alpha2)*sin(theta2),a2*cos(theta2);
       sin(theta2), cos(alpha2)*cos(theta2), -sin(alpha2)*cos(theta2), a2*sin(theta2);
       0, sin(alpha2), cos(alpha2),d2;
       0, 0, 0, 1 ];
A23 = [cos(theta3), -cos(alpha3)*sin(theta3), sin(alpha3)*sin(theta3),a3*cos(theta3);
       sin(theta3), cos(alpha3)*cos(theta3), -sin(alpha3)*cos(theta3),a3*sin(theta3);
       0, sin(alpha3), cos(alpha3),d3;
       0, 0, 0, 1 ];
A34 = [cos(theta4), -cos(alpha4)*sin(theta4), sin(alpha4)*sin(theta4),a4*cos(theta4);
       sin(theta4), cos(alpha4)*cos(theta4), -sin(alpha4)*cos(theta4), a4*sin(theta4);
       0, sin(alpha4), cos(alpha4),d4;
       0, 0, 0, 1 ];

A06 = A01*A12*A23*A34;
Envelope_1 = plot(A06(1,4), A06(3,4),'r.')
hold 'all'

end
end
