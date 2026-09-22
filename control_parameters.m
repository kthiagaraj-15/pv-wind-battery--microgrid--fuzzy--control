%% INITIALIZATION FOR pvwindupfc11
% Run this file before running the Simulink model.

%% Sample times
Ts_PWM     = 5e-6;
Ts_Control = 50e-6;
Ts_Power   = Ts_PWM;

%% Grid parameters
Fnom       = 50;
Vnom_grid  = 500e3;
Psc_grid   = 20000e6;

%% Three-level converter DC link
Pnom_dc_3L = 200e6;
Vnom_dc_3L = Vnom_grid/0.612;
H_3L       = 2/Fnom;

Clink_3L      = (2*Pnom_dc_3L*H_3L)/(Vnom_dc_3L^2);
Vc_Initial_3L = Vnom_dc_3L/2;

%% Transformer parameters
Pnom_3L      = Pnom_dc_3L;
Vnom_prim_3L = Vnom_grid;

m_nom_3L   = 0.8;
Vnom_sec_3L = 0.5*Vnom_dc_3L/sqrt(2)*sqrt(3)*m_nom_3L;

%% PWM and measurement filters
Fc_3L      = 33*Fnom;
Freq_Filter = 1000;

%% DC-link voltage controller
Kp_VDCreg_3L = 3;
Ki_VDCreg_3L = 300;

LimitU_VDCreg_3L = 1.5;
LimitL_VDCreg_3L = -1.5;

%% d-q current controllers
Kp_Ireg_3L = 0.1;
Ki_Ireg_3L = 15;

LimitU_Ireg_3L = 1.5;
LimitL_Ireg_3L = -1.5;

%% Additional converter calculation
Lact = 0.15*(Vnom_sec_3L^2/Pnom_3L)/(2*pi*Fnom);
%% Wind-turbine Cp coefficients
c1 = 0.5176;
c2 = 116;
c3 = 0.4;
c4 = 5;
c5 = 21;
c6 = 0.0068;

%% Load fuzzy controllers
if isfile("pv11k1.fis")
    pv11 = readfis("Pv11k1.fis");
else
    warning("PV11.fis is missing.");
end

if isfile("BCMS11.fis")
    BCMS11 = readfis("BCMS11.fis");
else
    warning("BCMS11.fis is missing.");
end

disp("pvwindupfc11 parameters loaded into MATLAB workspace.");
initialize_pvwindupfc11
set_param('pvwindupfc11','SimulationCommand','update');