R_0 = 2.4; %A single infected person will infect about R_0 others in a totally susceptible population

N = 67.89e6; %Population of the UK (2020)

I_duration=7;
H_duration=8.4;
H_ICU_duration=12.4;

a1 = 2*R_0/(N*I_duration);
a2 = 2*R_0/(N*H_duration);
a3 = 2*R_0/(N*H_ICU_duration);


tspan = 0:1:365; %Model for the next 360 days
y0 = [N, 0, 2, 0,0, 0]; %Coronavirus count of UK

[t,y]=ode45(@(t,y) ode_fun_UKcovid(t,y,a1,a2,a3), tspan, y0); %solve ODE system
[endT,endS,endR]=findEnd(y); %calculating end of infection

%%Graphing the models
plotchoice=3;

switch plotchoice
    
    case 1
plot(t,y(:,4),'LineWidth', 1.5, 'MarkerSize', 18)
hold on
yline(2.4*N/1000)
xlim([0 365])
ylim([0 3e6])
legend('Total number of people in hospital','Number of hospital beds in the UK','Location','Best');
xlabel('Days after start of pandemic')
ylabel('Population')
title('No-policy SEIR model, hosptialisations v NHS capacity')
grid on;
grid minor;
set(gca, 'FontSize', 26)

    case 2
plot(t,y(:,5),'LineWidth', 1.5, 'MarkerSize', 18)
hold on
yline(7.3*N/100000)
xlim([0 365])
ylim([0 5.5e5])
legend('Total number of people in critical care','Number of critical care beds in the UK','Location','Best');
xlabel('Days after start of pandemic')
ylabel('Population')
title('No-policy SEIR model, ICU admissions v NHS capacity')
grid on;
grid minor;
set(gca, 'FontSize', 26)

    case 3
plot(t,y,'LineWidth', 1.5, 'MarkerSize', 18)
xlim([0 365])
legend('Susceptible people','Exposed people','Infectious people','Non-ICU patients','ICU patients','Removed people', 'Location', 'Best')
xlabel('Days after start of pandemic')
ylabel('Population')
title('Predicted Spread of COVID-19 in the UK in a no-policy environment')
grid on;
grid minor;
set(gca, 'FontSize', 26)
end

%%finding when COVID-19 is eradicated
 fprintf('COVID-19 is eradicated in the UK when, t=%d, S=%d, R=%d\n', endT, endS, endR)