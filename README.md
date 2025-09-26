
# ✈️ Flight Envelope Analysis in MATLAB

This repository provides MATLAB implementations for analyzing the **flight envelope** of fixed-wing aircraft.
It includes both **jet-powered** and **propeller-driven** aircraft models.

The project computes key performance metrics such as:

* Stall speed, minimum thrust/power speed, and maximum velocity
* Thrust Required vs Thrust Available (jet)
* Power Required vs Power Available (propeller)
* Altitude-dependent performance envelopes
* Full 3D flight envelope visualization across altitude and flight path angles

The project can be used for **educational purposes**, **aircraft design studies**, and **performance analysis**.

---

## 📂 Features

### Jet Aircraft

* **Thrust Required (TR)** and **Thrust Available (TA)** analysis
* **Stall, minimum thrust, and maximum velocity** calculation
* **CL vs. α (angle of attack)** and **elevator deflection (δe)** analysis
* **Altitude vs Velocity envelopes** (Vmin, Vmax, Vstall)
* **3D Flight Envelope** across altitude and flight path angle

### Propeller Aircraft

* **Power Required (PR)** and **Power Available (PA)** analysis
* **Stall, minimum power, and maximum velocity** calculation
* **Angle of attack and elevator deflection** for critical speeds
* **Altitude vs Velocity envelopes** (Vmin, Vmax, Vstall)
* **3D Flight Envelope** across altitude and flight path angle

---

## ⚙️ Inputs

Each script defines its own parameters.

### Jet Aircraft:

```matlab
% Aircraft & environment data
W   = 33135 * 9.8;     % Weight [N]
S   = 88.26;           % Wing area [m^2]
AR  = 5.9;             % Aspect ratio
Fmax = 12700 * 9.8;    % Max thrust [N]
TSFC = 0.155;          % Thrust specific fuel consumption [kg/N-hr]
n   = 2;               % Number of engines
```

### Propeller Aircraft:

```matlab
W   = 12900;           % Weight [N]
S   = 16.26;           % Wing area [m^2]
AR  = 7.4;             % Aspect ratio
CLmax = 2.4;           % Maximum lift coefficient
Pa_max = 216250;       % Max available power at sea level
CD0  = 0.026;          % Zero-lift drag coefficient
K    = 0.054;          % Induced drag factor
```

---

## 📊 Sample Output Plots

### Jet Aircraft

1. **CL vs Alpha**
   ![CL vs Alpha](https://dummyimage.com/600x300/4dbeee/ffffff\&text=CL+vs+Alpha)

2. **Thrust vs Velocity**
   ![Thrust vs Velocity](https://dummyimage.com/600x300/edb120/ffffff\&text=Thrust+vs+Velocity)

3. **Altitude vs Velocity Envelope**
   ![Flight Envelope](https://dummyimage.com/600x300/77ac30/ffffff\&text=Flight+Envelope)

4. **Full 3D Flight Envelope**
   ![3D Flight Envelope](https://dummyimage.com/600x300/2ca02c/ffffff\&text=3D+Envelope)

---

### Propeller Aircraft

1. **Power vs Velocity**
   ![Power vs Velocity](https://dummyimage.com/600x300/f39c12/ffffff\&text=Power+vs+Velocity)

2. **Altitude vs Velocity Envelope**
   ![Flight Envelope](https://dummyimage.com/600x300/27ae60/ffffff\&text=Altitude+Envelope)

3. **Full 3D Flight Envelope**
   ![3D Flight Envelope](https://dummyimage.com/600x300/3498db/ffffff\&text=3D+Envelope)

---

## 🚀 Usage

1. Clone this repository

   ```bash
   git clone https://github.com/your-username/flight-envelope-matlab.git
   cd flight-envelope-matlab
   ```

2. Open MATLAB and run the desired script:

   **For Jet Aircraft:**

   ```matlab
   clc; clearvars;
   flightEnvelope(0); % Steady flight
   flightEnvelope(5); % Climb
   ```

   **For Propeller Aircraft:**

   ```matlab
   clc; clear all;
   run('propeller_envelope.m');
   ```

3. Plots will be generated automatically.

---

## 📌 Notes

* Requires an **ISA atmosphere function** (`atm_table.m`) for density variation.
* The script assumes **standard atmosphere conditions**.
* Extendable for different aircraft geometries and propulsion systems.

---

## 📎 Example `atm_table.m`

If you don’t already have `atm_table.m`, here is a minimal version you can include:


function data = atm_table(h_km)
    % Returns a simple ISA atmospheric table
    % Input: altitude in km
    % Output: [altitude, T(K), p(Pa), a(m/s), rho(kg/m^3)]
    
    h = 0:1:21; % km
    T0 = 288.15; % K
    a_lapse = -6.5; % K/km (up to 11 km)
    R = 287.05; % J/kgK
    g0 = 9.80665; % m/s^2
    
    data = zeros(length(h),5);
    for i=1:length(h)
        if h(i) <= 11
            T = T0 + a_lapse*h(i);
            p = 101325*(T/T0)^(-g0/(a_lapse*R));
        else
            T = 216.65;
            p = 22632*exp(-g0*(h(i)-11e3)/(R*T));
        end
        rho = p/(R*T);
        a = sqrt(1.4*R*T);
        data(i,:) = [h(i), T, p, a, rho];
    end
end


---
