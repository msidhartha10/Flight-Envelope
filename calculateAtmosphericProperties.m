function atmosphericProperties = calculateAtmosphericProperties(geometricAltitude)
 z = input("Enter the Geometric Altitude (in meters): ");
 geometricAltitude = z * 1000;

    % Constants
    g = 9.80665;
    R = 287;
    Re = 6356766;

    % Other constants 
    rho_ssl = 1.225;
    P_ssl = 101325;
    T_ssl = 288.16;

    % Preallocate arrays
    delta_h = zeros(size(geometricAltitude));
    t = zeros(size(geometricAltitude));
    P = zeros(size(geometricAltitude));
    rho = zeros(size(geometricAltitude));

for i = 1:length(geometricAltitude)
    h(i) = (Re * geometricAltitude(i)) / (Re + geometricAltitude(i));

    
    if geometricAltitude(i) == 0 
        t(i) = T_ssl;
        P(i) = P_ssl;
        rho(i) = rho_ssl;
    end
        
    if geometricAltitude(i) > 0 && geometricAltitude(i) <=11000
        a = -0.0065;
        x = ((g)/(a*R));
        delta_h(i) = h(i) - 0;
        t(i) = T_ssl + (a*delta_h(i));
        tr(i)=t(i)/ T_ssl;
        P(i) = P_ssl * (tr(i)^(-x)); 
        %P(i) = P(i)/(10^5);
        rho(i) = rho_ssl * (tr(i)^(-(x+1)));
    end
if geometricAltitude(i) > 11000 && geometricAltitude(i) <= 25000
    % Find the index corresponding to 11000 meters in geometric altitude
    [~, index_11000] = min(abs(geometricAltitude - 11000));

    delta_h(i) = h(i) - h(index_11000);
    y = ((g) / (t(index_11000) * R)) * delta_h(i); 
    t(i) = 216.6600 ;
    P(i) = P(index_11000) * exp(-y);
    rho(i) = rho(index_11000) * exp(-y);
end


     if geometricAltitude(i) > 25000 && geometricAltitude(i) <=47000
        a = 0.003;
        x = ((g)/(a*R));
        delta_h(i) = h(i) - h(26);
        t(i) = t(26) + (a*delta_h(i));
        tr(i)=t(i)/ t(26);
        P(i) = P(26) * (tr(i)^(-x));
        rho(i) = rho(26) * (tr(i)^(-(x+1)));
     end

     if geometricAltitude(i) > 47000 && geometricAltitude(i) <=53000
        delta_h(i) = h(i) - h(48);
        y = ((g)/(t(48)*R))*delta_h(i);
        t(i) = t(48) ;
        P(i) = P(48)* exp(-y);
        rho(i) = rho(48) * exp(-y);
     end

     if geometricAltitude(i) > 53000 && geometricAltitude(i) <=79000 
        a = -0.0045;
        x = ((g)/(a*R));
        delta_h(i) = h(i) - h(54);
        t(i) = t(54) + (a*delta_h(i));
        tr(i)=t(i)/ t(54);
        P(i) = P(54) * (tr(i)^(-x));
        rho(i) = rho(54) * (tr(i)^(-(x+1)));
     end

    if geometricAltitude(i) > 79000 && geometricAltitude(i) <=82000
        delta_h(i) = h(i) - h(80);
        y = ((g)/(t(80)*R))*delta_h(i);
        t(i) = t(80) ;
        P(i) = P(80)* exp(-y);
        rho(i) = rho(80) * exp(-y);
     end
end

    % AT matrix
    atmosphericProperties = [geometricAltitude, h, t', P', rho'];

    % Plotting (optional, comment out if not needed)
    figure;
    plot(geometricAltitude, t);
    xlabel("Geometric Altitude (m)");
    ylabel("Temperature (K)");
end