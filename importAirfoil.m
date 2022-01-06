function af = importAirfoil(file)
% Airfoil coordinates import function
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
% ----- INPUTS -----
% file - full path to document with airfoil data
% ----- OUTPUTS -----
% af - airfoil coordinates
% --------------------

if(isfile(file))
  fid = fopen(file, 'r');
  l = textscan(fid, '%s', 'Delimiter', newline);
  fclose(fid);
  l = l{1,1};
  af = []; 
  h = 1;

  for i = 1:length(l)
    if(~isempty(l{i}))
      data = sscanf(l{i}, '%f %f');
      if(h && length(data) == 2 && data(1) > -0.1 && data(1) < 1.1 &&
          data(2) > -1.1 && data(2) < 1.1)
        % First coordinate if there is both x and y data
        % Range for x is [-0.1, 1.1] and for y is [-1.1, 1.1]
        h = 0;
        af = [af; data.'];
      elseif(~h && length(data) == 2)
        af = [af; data.'];
      end     
    end
  end
  if(length(af) > 0)
    if(any(af(:, 1) > 1.1))
      % Data is probably multiplied by 100
      af = af/100;
    end
    
    d = diff(af(:, 1));
    if(sum(d < 0) == 1)
      % Lednicer format
      i = find(d < 0);
      af = [flipud(af(1:i, :)); af((i+1):end, :)];
    end
    af = [af(1, :); unique(af(2:end-1, :), 'rows', 'stable'); af(end, :)];
  end
else
  af = [];
end
end