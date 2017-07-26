%input data stored in variable x
%clear;
%load x;

% initial config of the experiment
population  = 30;
generations = 10;

%baseline values
baseline_fitness = 1200;
baseline_lines = [];
baseline_maxlines = [];

% plot the best fitness score in each generation
for i=1:generations
    ind = x(:,1) == i;
    arr_of_interest = x(ind,:);
    if isempty(arr_of_interest)
        results(i,:) = [i;0;0;0;0];
        baseline_fitness(i) = 0;
        baseline_lines(i) = 99999;
        baseline_maxlines(i) = 99999;
    else
        [~, ind1] = max(arr_of_interest(:,3));
        results(i,:) = arr_of_interest(ind1,:);
        baseline_fitness(i) = arr_of_interest(1,3);
        baseline_lines(i) = arr_of_interest(1,4);
        baseline_maxlines(i) = arr_of_interest(1,5);
    end
end

plot(results(:,3)-baseline_fitness','-o');

figure;
plot(results(:,4)-baseline_lines','-o')

figure;
plot(results(:,5)-baseline_maxlines','-o');

