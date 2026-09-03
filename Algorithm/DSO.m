function D = DSO(Vpv, Ipv)
    persistent u;
    persistent dcurrent;
    persistent pbest;
    persistent p;
    persistent dc;
    persistent v;
    persistent counter;
    persistent gbest;

    if isempty(counter)
        counter = 0;
    end
    if isempty(dcurrent)
        dcurrent = 0.9;
    end
    if isempty(gbest)
        gbest = 0.9;
    end
    if isempty(p)
        p = zeros(4, 1);
    end
    if isempty(v)
        v = zeros(4, 1);
    end
    if isempty(pbest)
        pbest = zeros(4, 1);
    end
    if isempty(u)
        u = 1;
    end
    if isempty(dc)
        dc = [0.1910; 0.3394; 0.4279; 0.4883];
    end

    if counter >= 1 && counter < 300
        D = dcurrent;
        counter = counter + 1;
        return;
    end

    counter = 0;

    if u >= 1 && u <= 4
        if (Vpv * Ipv) > p(u)
            p(u) = Vpv * Ipv;
            pbest(u) = dcurrent;
        end
    end

    u = u + 1;
    if u == 6
        u = 1;
    end

    if u <= 4
        D = dc(u);
        dcurrent = D;
        counter = 1;
    elseif u == 5
        [~, i] = max(p);
        gbest = pbest(i);
        D = gbest;
        dcurrent = D;
        counter = 1;

        for j = 1:4
            v(j) = updatevelocity(v(j), pbest(j), dc(j), gbest);
            dc(j) = updateduty(dc(j), v(j));
        end
    else
        D = 0.1;
    end
end

function vfinal = updatevelocity(velocity, pobest, d, gwbest)
    Trial_Position = pobest;
    LocalBestPosition = gwbest;
    mui = rand;

    opCrossOver = randi(3);
    if opCrossOver == 1
        mpo = 1 - mui;
        New_Team_Position = LocalBestPosition * mpo + Trial_Position * mui;
    elseif opCrossOver == 2
        mpo = 1 - mui;
        New_Team_Position = LocalBestPosition * mpo + Trial_Position * mui;
    else
        New_Team_Position = Trial_Position;
    end

    vfinal = New_Team_Position - d;
end

function dnew = updateduty(d, v)
    dnew = d + v;
    dnew = max(0, min(1, dnew)); % Ensure duty cycle remains within bounds
end
