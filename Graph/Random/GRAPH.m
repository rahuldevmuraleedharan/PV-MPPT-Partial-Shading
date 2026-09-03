% List of .fig files to merge and their corresponding colors
figFiles = {'PO.fig','PSO.fig','GWO.fig','FSSO.fig','DSO.fig'};
colors = {'g','m','b','c','r'}; % 'c' is used for DSO to avoid duplicate colors

% Create a new figure
newFig = figure;
newAx = axes(newFig);
hold(newAx, 'on'); % Hold on to add multiple plots to the same axes

% Loop through each .fig file
for k = 1:length(figFiles)
    % Open the .fig file using hgload
    fig = hgload(figFiles{k});
    
    % Get the axes handle from the opened figure
    ax = findall(fig, 'type', 'axes');
    
    % Loop through all axes in the figure
    for axIdx = 1:length(ax)
        % Get the children of the axes (the plotted data)
        dataObjects = get(ax(axIdx), 'Children');
        
        % Copy each data object to the new figure's axes
        for j = 1:length(dataObjects)
            % Copy the object to the new figure
            newObj = copyobj(dataObjects(j), newAx);
            % Set the color of the new object
            if isprop(newObj, 'Color')
                newObj.Color = colors{k};
            elseif isprop(newObj, 'EdgeColor')
                newObj.EdgeColor = colors{k};
            elseif isprop(newObj, 'FaceColor')
                newObj.FaceColor = colors{k};
            end
        end
    end
    
    % Close the opened figure
    close(fig);
end

% Customize your plot (optional)
xlabel(newAx, 'Time');
ylabel(newAx, 'Power');
title(newAx, 'Comparison Plot of P&O, PSO, DSO, GWO, and FSSO under Random Shading');
legend(newAx, {'P&O', 'PSO', 'GWO', 'FSSO', 'DSO'}); % Adjust legend as needed

hold(newAx, 'off');