<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<div align="center">

  <img src="https://user-images.githubusercontent.com/47887796/184088035-fb18c63a-770f-4ec1-8d89-40d29fae4862.jpg" alt="Logo" width="300">

  <h1 align="center">Robotic Arm</h1>

  <p align="center">
   Three Link Robotic Arm with PD Controller
    <br />
    <br />
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li>
          <a href="#solidworks-model">Solidworks model</a>
        </li>
        <li>
          <a href="#inertia-matrix-taken-at-the-output-coordinate-system">Inertia matrix taken at the output coordinate system</a>
        </li>
        <li>
          <a href="#modified-dh-parameters">Modified DH Parameters</a>
        </li> 
        <li>
          <a href="#forward-kinematics">Forward Kinematics</a>
        </li> 
        <li>
          <a href="#inverse-kinematics">Inverse Kinematics</a>
        </li> 
        <li>
          <a href="#velocity-kinematics---the-jacobian">Velocity kinematics - The Jacobian</a>
        </li> 
        <li>
          <a href="#dynamic">Dynamic</a>
                  <ul>
                  <li>
                     <a href="#g-and-m">G and M</a>
                  </li>
                  <li>
                     <a href="#c">C</a>
                  </li>
                  </ul>
        </li> 
        <li>
          <a href="#workspace-of-the-robot">Workspace of the robot</a>
        </li> 
        <li>
          <a href="#animation-of-the-robot">Animation of the Robot</a>
        </li> 
      </ul>
    </li>
  </ol>
</details>


<!-- ABOUT THE PROJECT -->
## About The Project

This robot was constructed based on kawasaki rs006l robot. It was a pick and place manipulator.

### Built With

Componenets and Modules which were used in this project, are listed as follow:

- DC motor with potentiometer for feedback
- Arduino Uno
- L298 motor driver
- Shafts and Ball bearings
- Couplings 

<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Solidworks model
<div align="justify">
We used Solidworks to model our robot and 3d print it.
  
</div> 

<div align = "center"> 
  <img src = "https://user-images.githubusercontent.com/47887796/184089393-eb2c8c91-1e12-4302-95fd-bad68de09803.jpg" width = "600"> 
<br><br><br>
  <img src = "https://user-images.githubusercontent.com/47887796/184089548-f54f0acf-b3ba-4cdf-ab32-539fd287456a.jpg" width = "600"> 
</div>

### inertia matrix taken at the output coordinate system
From Solidworks:
```mat
I6 = [4653.13,        -6162.13,          0;
      -6162.13,        9478.04,          0;
      0,                     0,    13824.93]*1e-9;
I3 = [1056480.93,    -41967.32,     211.71;
      -41967.32,       36006.5,   -5156.53;
      211.71,         -5156.53, 1064752.14]*1e-9;
I2 = [795868.46,      47795.59,    2559.05;
      47795.59 ,     602973.53,     6308.8;
      2559.05  ,        6308.8,   755664.73]*1e-9;
```

### Modified DH Parameters
<div align="justify">
<table>
  <tr>
    <th>         </th>
    <th>a (i-1)</th>
    <th>alpha (i-1)</th>
    <th> d(i) </th>
    <th> theta(i) </th>
  </tr>
  <tr>
    <td>i=1</td>
    <td>0</td>
    <td>0</td>
     <td>0.46</td>
    <td>theta1</td>
  </tr>
  <tr>
    <td>i=2</td>
    <td>-0.12</td>
    <td>-90</td>
    <td>0</td>
    <td>theta2</td>
  </tr>
  <tr>
    <td> i=3 </td>
    <td>0.67</td>
    <td>0</td>
    <td>0</td>
    <td>theta3</td>
  </tr>
  <tr>
    <td> i=4 </td>
    <td>0</td>
    <td>-90</td>
    <td>0.7</td>
    <td>0</td>
  </tr>

</table>
</div>

### Forward Kinematics
From DH parameters we can calculate T matrices.
``` mat
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
   
 Ttotal = T1*T2*T3*T4;

```

### Inverse Kinematics
<div align="justify">
With as many nonzero DH parameters as there are inverse
kinematics problems, the complexity increases.For our manipulator, one of the ai, d2 and d3 are zero, α1 and α3 are 0 and
α2 is −π2 . Thus, geometric approach is the simplest and most
natural approach in this case. This geometric approach entails projecting the manipulator
onto the Xi−1-Yi−1 plane and solving a simple trigonometry
problem to solve for the joint variable qi.
<br>Source: Robot Modeling and Control , Spong

<div align = "center"> 
  <img src = "https://user-images.githubusercontent.com/47887796/184095680-54da5ca6-bc73-4e5a-909b-7abd6f65d59f.PNG" width = "600"> 
<br><br><br>
  <img src = "https://user-images.githubusercontent.com/47887796/184096136-8e7751cb-10d8-4a33-9ecc-317429b3e1b3.PNG" width = "600"> 
  <br><br><br>
    <img src = "https://user-images.githubusercontent.com/47887796/185741591-17478c8d-58a4-4e59-a248-b2cd2bc31202.PNG" width = "600"> 

</div>
</div>  

### VELOCITY KINEMATICS - THE JACOBIAN
Since all the Joint are revolute joints, we have:
<br> Jv(i) = z(i-1) x ( o(n) - o(i-1))
<br> Jw(i)= z(i-1)
```mat
o0_0 = [0;0;0];

o1_0 = T1(1:3,4);
% o1_0 = simplify(o1_0);
z1 = T1(1:3,3);

x2 = T1*T2;
o2_0 = x2(1:3,4);
z2 = x2(1:3,3);

x3 = T1*T2*T3;
o3_0 = x3(1:3,4);
z3 = x3(1:3,3);

x4 = T1*T2*T3*T4;
o4_0 = x4(1:3,4);
z4 = x4(1:3,3);

%%%%%%%%%%%%%%%%%%%%%%%%%jacobian
jv1 = cross(z1,o4_0-o1_0);
j1 = [jv1;z1];
O = o4_0-o2_0;
jv2= cross(z2,O);
j2 =[jv2;z2];
Op = o4_0-o3_0;
jv3 = cross(z3,Op);
j3 = [jv3;z3];
 
%jacobian from frame 3 to frame 0:
J = [j1,j2,j3];
J3_0 = J;
% J=simplify(J);
JV_6 = J(1:3,1:3);
JW_6 = J(4:6,1:3);
```

### Dynamic
<div align="justify">
<div align = "center"> 
  <img src = "https://user-images.githubusercontent.com/47887796/184100126-4d61d8b7-3eda-4291-90a1-944c81111b03.PNG"> 
<br><br><br>
    <img src = "https://user-images.githubusercontent.com/47887796/184100773-4d92b349-8a7c-400e-a957-492db304ea67.PNG"> 
<br><br><br>
      <img src = "https://user-images.githubusercontent.com/47887796/184101248-ec2512fd-d8cb-423b-a5cf-cde7bbea391b.PNG"> 
</div>
  
#### G and M
  
  ```mat
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
  
  % matrix M
  link6 = m6*(transpose(JV_6))*JV_6+(transpose(JW_6))*I6*JW_6;
  link3 = m3*(transpose(JV_3))*JV_3+(transpose(JW_3))*I3*JW_3;
  link2 = m2*(transpose(JV_2))*JV_2+(transpose(JW_2))*I2*JW_2;
  M = link6+link3+link2;
 ```
 #### C
  ```mat
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
  ```
  
</div>

### Workspace of the robot
<div align="justify">
  For determining the workspace of the robot, we wrote a MATLAB code.
  The code is provided in the files.
 
  <div align = "center"> 
  <img src = "https://user-images.githubusercontent.com/47887796/185763609-409396f4-a32d-463a-9d3f-63957d514288.png" width = "400"> 
<br>
  <img src = "https://user-images.githubusercontent.com/47887796/185763671-6bfaa6b0-4992-4189-b788-3e1e9c67192d.png" width = "400"> 
</div>


</div>

### Animation of the robot

<div align = "center"> 
  <img src = "https://user-images.githubusercontent.com/47887796/184110608-2d10a186-4071-4c18-ad21-4238f4568979.gif" width="400"> 
</div>

### DC Motor with Feedback using MG996R Servo motor
<div align="justify">
  We opened MG996R servo motors and got the inner circuits out. Then used the inner potentiometer for getting feedback on the position of the motor. The DC motor then was drived with the help of L298 motor driver.
</div>


### Simulink
<div align="justify">
A simple PD controller was applied: 
<div align = "center"> 
    <img src = "https://user-images.githubusercontent.com/47887796/184577594-6586efb9-cff8-435f-ad93-2f84fbb184aa.PNG" > 
</div>
Simulation results:
  </br>
Motor one:
<div align = "center"> 
    <img src = "https://user-images.githubusercontent.com/47887796/184577913-c0cf85b4-ef94-4a36-8ff9-67c9102d52b2.png" width="600"> 
</div>   
  Motor two:
  </br>
  <div align = "center"> 
    <img src = "https://user-images.githubusercontent.com/47887796/184577986-9abe825b-289b-4f00-81eb-cb1667a1caa4.png" width="600"> 

</div>



</div>

### Constructed

<div align="justify">
<div align = "center"> 
   <img src = "https://user-images.githubusercontent.com/47887796/184113994-e5ea5f55-74c5-4067-85c3-fa7eadab70bb.jpg" width="500"> 
</div>
</div>




