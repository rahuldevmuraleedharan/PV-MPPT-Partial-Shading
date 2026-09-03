% Define the function PnO_MPPT with inputs Vpv and Ipv
function D = PnO_MPPT(Vpv, Ipv)
    persistent dcurrent; % Current duty cycle
    persistent Pprev; % Previous power
    persistent Vprev; % Previous voltage
    persistent dD; % Perturbation step size
    persistent Dir; % Direction of perturbation

    % Initialize variables if they are empty
    if isempty(dcurrent)
        dcurrent = 0.5; % Start with a mid-range duty cycle
    end
    if isempty(Pprev)
        Pprev = 0;
    end
    if isempty(Vprev)
        Vprev = 0;
    end
    if isempty(dD)
        dD = 0.01; % Perturbation step size
    end
    if isempty(Dir)
        Dir = 1; % Initial direction of perturbation (1: increase, -1: decrease)
    end

    % Calculate current power
    P = Vpv * Ipv;

    % Perturb and Observe Algorithm
    if P > Pprev % If power increases
        if Vpv > Vprev % If voltage increases
            dcurrent = dcurrent + dD * Dir; % Increase duty cycle
        else % If voltage decreases
            dcurrent = dcurrent - dD * Dir; % Decrease duty cycle
        end
    else % If power decreases
        Dir = -Dir; % Change direction
        dcurrent = dcurrent + dD * Dir; % Adjust duty cycle in new direction
    end

    % Ensure duty cycle remains within bounds
    dcurrent = max(0, min(1, dcurrent));

    % Update previous values
    Pprev = P;
    Vprev = Vpv;

    % Return current duty cycle
    D = dcurrent;
end
