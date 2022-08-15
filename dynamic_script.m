%% D-h parameter 
% q1=q(1,1);
% q2=q(2,1);
% q3=q(3,1);
% 
% q1d=qd(1,1);
% q2d=qd(2,1);
% q3d=qd(3,1);

syms theta1 theta2 theta3 theta4 
% theta1 = q1;
% theta2 = q2;
% theta3 = q3;
% theta4 = 0;
% theta5 = 0;
% theta6 = 0;

p = pi;
%a
a1=0;
a2=-0.06821;
a3=0.224;
a4=0;
a5=0;
a6=0;
%alpha
alphab1=  0;
alphab2= -p/2;
alphab3=  0;
alphab4= -p/2;
alphab5=  p/2;
alphab6= -p/2;

m6 = 0.01297;   %third link
m3 = 0.18712;  %second link
m2 = 0.33055;  %first link from the bottom

% inertia matrix taken at the output coordinate system
I6 = [4653.13,-6162.13,0;-6162.13,9478.04,0;0,0,13824.93]*1e-9;
I3 = [1056480.93,-41967.32,211.71;-41967.32,36006.5,-5156.53;211.71,-5156.53,1064752.14]*1e-9;
I2 = [795868.46,47795.59,2559.05;47795.59,602973.53,6308.8;2559.05,6308.8,755664.73]*1e-9;

% d
d1 = 0.178;
d2 = 0;
d3 = 0;
d4 = 0.1;
d5 = 0;
d6 = 0;
%theta
theta2 = -p/2 + theta2;
theta3 = -p/2 + theta3;
T1=[cos(theta1) -sin(theta1) 0 a1;
   sin(theta1)*cos(alphab1) cos(theta1)*cos(alphab1) -sin(alphab1) -sin(alphab1)*d1;
   sin(theta1)*sin(alphab1) cos(theta1)*sin(alphab1) cos(alphab1) cos(alphab1)*d1;
   0 0 0 1];
T2=[cos(theta2) -sin(theta2) 0 a2;
   sin(theta2)*cos(alphab2) cos(theta2)*cos(alphab2) -sin(alphab2) -sin(alphab2)*d2;
   sin(theta2)*sin(alphab2) cos(theta2)*sin(alphab2) cos(alphab2) cos(alphab2)*d2;
   0 0 0 1];
T3=[cos(theta3) -sin(theta3) 0 a3;
   sin(theta3)*cos(alphab3) cos(theta3)*cos(alphab3) -sin(alphab3) -sin(alphab3)*d3;
   sin(theta3)*sin(alphab3) cos(theta3)*sin(alphab3) cos(alphab3) cos(alphab3)*d3;
   0 0 0 1];
T4=[cos(theta4) -sin(theta4) 0 a4;
   sin(theta4)*cos(alphab4) cos(theta4)*cos(alphab4) -sin(alphab4) -sin(alphab4)*d4;
   sin(theta4)*sin(alphab4) cos(theta4)*sin(alphab4) cos(alphab4) cos(alphab4)*d4;
   0 0 0 1];
% T5=[cos(theta5) -sin(theta5) 0 a5;
%    sin(theta5)*cos(alphab5) cos(theta5)*cos(alphab5) -sin(alphab5) -sin(alphab5)*d5;
%    sin(theta5)*sin(alphab5) cos(theta5)*sin(alphab5) cos(alphab5) cos(alphab5)*d5;
%    0 0 0 1];
% T6=[cos(theta6) -sin(theta6) 0 a6;
%    sin(theta6)*cos(alphab6) cos(theta6)*cos(alphab6) -sin(alphab6) -sin(alphab6)*d6;
%    sin(theta6)*sin(alphab6) cos(theta6)*sin(alphab6) cos(alphab6) cos(alphab6)*d6;
%    0 0 0 1];
Ttotal = T1*T2*T3;
%% origin
o0_0 = [0;0;0];

o1_0 = T1(1:3,4);
% o1_0 = simplify(o1_0);
z1 = T1(1:3,3);

x2 = T1*T2;
o2_0 = x2(1:3,4);
% o2_0 = simplify(o2_0);
z2 = x2(1:3,3);

x3 = T1*T2*T3;
o3_0 = x3(1:3,4);
% o3_0 = simplify(o3_0);
z3 = x3(1:3,3);

x4 = T1*T2*T3*T4;
o4_0 = x4(1:3,4);
% o4_0 = simplify(o4_0);
z4 = x4(1:3,3);
% 
% x5 = T1*T2*T3*T4*T5;
% o5_0 = x5(1:3,4);
% % o5_0 = simplify(o5_0);
% z5 = x5(1:3,3);
% 
% x6 = T1*T2*T3*T4*T5*T6;
% o6_0 = x6(1:3,4);
% % o6_0 = simplify(o6_0);
% z6 = x6(1:3,3);
%%%%%%%%%%%%%%%%%%%%%%%%%jacobian
jv1 = cross(z1,o4_0-o1_0);
j1 = [jv1;z1];
O = o4_0-o2_0;
jv2= cross(z2,O);
j2 =[jv2;z2];
Op = o4_0-o3_0;
jv3 = cross(z3,Op);
j3 = [jv3;z3];
% Op1 = o6_0-o4_0;
% jv4 = cross(z4,Op1);
% j4 = [jv4;z4];
% Op2 = o6_0-o5_0;
% jv5 = cross(z5,Op2);
% j5 = [jv5;z5];
% Op3 = o6_0-o6_0;
% jv6 = cross(z5,Op3);
% j6 = [jv6;z6];
 
%jacobian from frame 3 to frame 0:
J = [j1,j2,j3];
J3_0 = J;
% J=simplify(J);
JV_6 = J(1:3,1:3);
JW_6 = J(4:6,1:3);
%%
% J_again=det(J);
% simplify(J_again)
% dd=70*cos(theta2) - 12*sin(theta3) + 67*sin(theta2)*sin(theta3) - 70*cos(theta2)*cos(theta3)^2 + 70*cos(theta3)*sin(theta2)*sin(theta3)==0;
% ddd=solve(dd);
% pretty(ddd)
%% j3_0
% % % % jv1 = cross(z1,o3_0-o1_0);
% % % % j1 = [jv1;z1];
% % % % O = o3_0-o2_0;
% % % % jv2= cross(z2,O);
% % % % j2 =[jv2;z2];
% % % % Op = o3_0-o3_0;
% % % % jv3 = cross(z3,Op);
% % % % j3 = [jv3;z3];
% % % % z4 = [0;0;0];
% % % % z5 = [0;0;0];
% % % % z6 = [0;0;0];
% % % % jv4 = [0;0;0];
% % % % jv5 = [0;0;0];
% % % % jv6 = [0;0;0];
% % % % %  jacobian from frame 3 to frame 1
% % % % JV_3 = [jv1,jv2,jv3,jv4,jv5,jv6];
% % % % JW_3 = [z1,z2,z3,z4,z5,z6];
%  J = [j1,j2,j3,j4,j5,j6]
%% j2_0
jv1 = cross(z1,o3_0-o1_0);
j1 = [jv1;z1];
O = o3_0-o2_0;
jv2= cross(z2,O);
j2 = [jv2;z2];
j3 = [0;0;0;z3];
%jacobian from frame 2 to frame 0:
J2_0 = [j1,j2,j3];
JV_3 = J2_0(1:3,1:3);
JW_3 = J2_0(4:6,1:3);


% % jv3 = [0;0;0];
% % jv4 = [0;0;0];
% % jv5 = [0;0;0];
% % jv6 = [0;0;0];
% % JV_2 = [jv1,jv2,jv3,jv4,jv5,jv6];
% % z3 = [0;0;0];
% % JW_2 = [z1,z2,z3,z4,z5,z6];

%jacobian from frame 1 to frame 0:
jv1 = cross(z1,o2_0-o1_0);
j1 = [jv1;z1];
O = o2_0-o2_0;
jv2= cross(z2,O);
j2 = [jv2;z2];
j3 = [0;0;0;z3];
J1_0 = [j1,j2,j3];
JV_2 = J1_0(1:3,1:3);
JW_2 = J1_0(4:6,1:3);
%% dynamic
% matrix G
% syms teta2 teta3
%x is the angular from solid
x=61.64*(p/180);
teta2 = theta2 + p/2;
teta3 = theta3 + p/2;
p1 = m2 * 9.8 * 0.46;
p2 = m3 * 9.8 * (0.67*sin(teta2+x)+0.46); %%%%x
p3 = m6 * 9.8 * (0.7*sin(teta2+teta3+x)+0.67*sin(teta2+x)+0.46);
P = p1 + p2 + p3;
phi1 = 0;
phi2 = (m3+m6)*9.8*0.67*cos(teta2+x);
phi3 = m6*9.8*0.7*cos(teta2+teta3+x);
G = [phi1;phi2;phi3];

%untill hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee

% matrix M
link6 = m6*(transpose(JV_6))*JV_6+(transpose(JW_6))*I6*JW_6;
link3 = m3*(transpose(JV_3))*JV_3+(transpose(JW_3))*I3*JW_3;
link2 = m2*(transpose(JV_2))*JV_2+(transpose(JW_2))*I2*JW_2;
M = link6+link3+link2;

%% matrix c
syms theta1(t) theta2(t) theta3(t) 
THETA = [theta1 theta2 theta3];  %% watch out teta2 and teta3
C = sym(zeros(3,3));
c = sym(zeros(3,3,3));
for k = 1:3
        for j = 1:3
            for i = 1:3
                F1 = M(k,j);
                F2 = M(k,i);
                F3 = -M(i,j);
                c(i,j,k) = 0.5*(diff(F1,THETA(i)) + diff(F2,THETA(j)) + diff(F3,THETA(k)));
            end
        end
end
%% C
for k=  1:3
for i = 1:3
for j = 1:3
    C(i,k) = C(i,k)+c(i,j,k);
end
end
end
isequal(simplify(M(3,1),"Steps",150),simplify(M(1,3),"Steps",150))
isequal(simplify(M(2,1),"Steps",150),simplify(M(1,2),"Steps",150))
isequal(simplify(M(2,3),"Steps",150),simplify(M(3,2),"Steps",150))
vpa(simplify(C,"Steps",150),4)
