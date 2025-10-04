% Revenue function: R(a,b) = 7a + 12 where a is trout and b salmon.

f = [-7, -12] % Since we are actually minimizing the objective function.
A = [1,2; 2,3] 
b = [1000; 1600]
% Since a+2b<=1000 and 2a+3b<=1600.
lb = zeros(2,1);

[fish, obj, exitflag] = linprog(f, A, b, [], [], lb)

% The fisherwoman must catch 200 trout and 400 salmon. She then has a
% revenue of 6200 dollars. Exitflag = 1, so a solution has been found.

% How does the solution change with trout price

% Set trout price range (from 5 to 9, step size 0.5)
trout_prices = 5:0.5:9;
salmon_price = 12; % Fixed salmon price

% Constraint matrix and vector
A = [2,1;3,2];
b = [1000;1600];
lb = zeros(2,1);

% Matrix to store results
results = zeros(length(trout_prices), 5); % [trout_price, salmon_quantity, trout_quantity, objective_value, exit_flag]

% Loop to calculate optimal solutions for different trout prices
for i = 1:length(trout_prices)
    % Update objective function (note: linprog minimizes, so add negative sign to prices)
    f = [-salmon_price, -trout_prices(i)];
    
    % Solve linear programming problem
    [fish, obj, exitflag] = linprog(f, A, b, [], [], lb);
    
    % Store results
    results(i, :) = [trout_prices(i), fish(1), fish(2), -obj, exitflag];
    
    % Display results
    fprintf('Trout Price: %.1f, Salmon Quantity: %.2f, Trout Quantity: %.2f, Total Revenue: %.2f\n', ...
        trout_prices(i), fish(1), fish(2), -obj);
end

% Plot results
figure;
subplot(2,2,1);
plot(results(:,1), results(:,2), 'r-o', 'LineWidth', 2);
xlabel('Trout Price');
ylabel('Salmon Quantity');
title('Salmon Quantity vs Trout Price');
grid on;

subplot(2,2,2);
plot(results(:,1), results(:,3), 'b-s', 'LineWidth', 2);
xlabel('Trout Price');
ylabel('Trout Quantity');
title('Trout Quantity vs Trout Price');
grid on;

subplot(2,2,3);
plot(results(:,1), results(:,4), 'g-^', 'LineWidth', 2);
xlabel('Trout Price');
ylabel('Total Revenue');
title('Total Revenue vs Trout Price');
grid on;

subplot(2,2,4);
plot(results(:,1), results(:,2), 'r-o', 'LineWidth', 2);
hold on;
plot(results(:,1), results(:,3), 'b-s', 'LineWidth', 2);
xlabel('Trout Price');
ylabel('Fish Quantity');
title('Salmon and Trout Quantity Comparison');
legend('Salmon', 'Trout', 'Location', 'best');
grid on;

% Display results table
fprintf('\n=== Results Summary ===\n');
fprintf('Trout Price\tSalmon Qty\tTrout Qty\tTotal Rev\tExit Flag\n');
fprintf('------------------------------------------------------------\n');
for i = 1:length(trout_prices)
    fprintf('%.1f\t\t%.2f\t\t%.2f\t\t%.2f\t\t%d\n', results(i,:));
end
