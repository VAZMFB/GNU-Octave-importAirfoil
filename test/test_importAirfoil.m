% Test importAirfoil
% Author: Milos D. Petrasinovic <mpetrasinovic@mas.bg.ac.rs>
% Structural Analysis of Flying Vehicles
% Faculty of Mechanical Engineering, University of Belgrade
% Department of Aerospace Engineering, Flying structures
% https://vazmfb.com
% Belgrade, 2022
% ---------------
%
% Copyright (C) 2022 Milos Petrasinovic <info@vazmfb.com>
%  
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as 
% published by the Free Software Foundation, either version 3 of the 
% License, or (at your option) any later version.
%   
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%   
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.
%
% --------------------
close all, clear all, clc, tic
disp([' --- ' mfilename ' --- ']);

addpath([pwd '\..\']);
afns = readdir([pwd '\airfoils'])(3:end); % airfoil names
N_afns = length(afns);

% - Import airfoil then show and save figure
figure(1)
hold on, box on, grid on
xlabel('x [-]'), ylabel('y [-]');
axis equal
for i = 1:N_afns;
  cla;
  disp([' Importing ' afns{i} ' [' num2str(i) '/' num2str(N_afns) ']']);
  x_y{i} = importAirfoil([pwd '\airfoils\' afns{i}]);
  plot([0 1], [0 0], 'LineWidth', 2)
  if(~isempty(x_y) && size(x_y{i}, 2) == 2) 
    plot(x_y{i}(:, 1), x_y{i}(:, 2), 'LineWidth', 2)
  end
  title(afns{i});
  path = [pwd '\figures\' strrep(strrep(afns{i}, '.', '-'), '/', ' ')];
  print(path, '-dpng');
  print(path, '-dsvg');
end

% - End of program
disp(' The program was successfully executed... ');
disp([' Execution time: ' num2str(toc, '%.2f') ' seconds']);
disp(' -------------------- ');