hydroForceElements = fields(body.hydroForce);

nElements = length(hydroForceElements);
elementString = hydroForceElements{1};
if nElements > 1
    for i=2:nElements
        elementString = [elementString ', ' hydroForceElements{i}]; 
    end
end

% Update bus signals with the name of hydroForce elements (hf1, hf2, etc)
h = [gcb '/Bus Selector'];
set_param(h, 'OutputSignals', elementString);

% Update number of switch inputs
h = [gcb '/Multiport Switch'];
set_param(h, 'Inputs', num2str(nElements));

% Connect bus outputs and switch inputs
for i = 1:nElements
    try
        add_line(gcb, ...
            ['Bus Selector/' num2str(i)], ...
            ['Multiport Switch/' num2str(i+1)],...
            'autorouting','on');
    catch
    end
end

% Connect the initial case (default hydroForce) to the end of the multiport switch (default case)
hydroForceIndexInitial = body.variableHydro.hydroForceIndexInitial;
try
    add_line(gcb, ...
        ['Bus Selector/' num2str(hydroForceIndexInitial)], ...
        ['Multiport Switch/' num2str(nElements+2)],...
        'autorouting','on');
catch
end