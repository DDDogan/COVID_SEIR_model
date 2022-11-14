function dydt = ode_fun_UKcovid(t,y,a1,a2,a3)

Pre_I = 5.8;
b = 1/Pre_I;

I_duration=7;
H_duration=8.4;
H_ICU_duration=12.4;

d1=1/I_duration;
d2=1/H_duration;
d3=1/H_ICU_duration;

S = y(1);
E= y(2);
I = y(3);
H = y(4);
H_ICU = y(5);
R=y(6);

g1=(15546-13875)/(53356-8957);
g2=(2120-1813)/15546;

dS=-a1*S.*I-a2*S.*H-a3*S.*H_ICU;
dE=a1*S.*I+a2*S.*H+a3*S.*H_ICU-b*E;
dI=b*E-g1*I-d1*I;
dH=g1*I-g2*H-d2*H;
dH_ICU=g2*H-d3*H_ICU;
dR=d1*I+d2*H+d3*H_ICU;

dydt = [dS; dE; dI; dH; dH_ICU; dR];
end
