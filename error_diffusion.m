function y = error_diffusion(x, algorithm)
%
% function 'error_diffusion' applies Floyd_Steinberg / Jarvis - Judice - Ninke /
% Stucki error diffusion to an image x, whici is assumed to be of type unint8
% algorithm is error diffusion type : following
% Floyd - Steinberg : fl_stein, 
% Jarvis - Judice - Ninke : jarvis
% Stucki : stucki

try    
    height=size(x,1);
    width=size(x,2);
    y=uint8(zeros(height,width));
    z=zeros(height+4,width+4);
    z(3:height+2,3:width+2)=x;
    
    type = -1;        
    if( strcmp('fl_stein', algorithm) )
        type = 1;
    elseif ( strcmp('jarvis', algorithm) )
        type = 2;
    elseif ( strcmp('stucki', algorithm) )
        type = 3;
    else
        error('Algorithm is not correct');
    end
        
    for i=3:height+2
        for j=3:width+2
            if z(i,j) < 128
              y(i-2,j-2) = 0;
              e = z(i,j);
            else
              y(i-2,j-2) = 255;
              e = z(i,j)-255;
            end

            if( type == 1)            
                z(i,j+1)=z(i,j+1)+7*e/16;
                z(i+1,j-1)=z(i+1,j-1)+3*e/16;
                z(i+1,j)=z(i+1,j)+5*e/16;
                z(i+1,j+1)=z(i+1,j+1)+e/16;
            elseif (type == 2)
                z(i, j+1) = z(i, j+1) + 7*e/48;
                z(i, j+2) = z(i, j+2) + 5*e/48;

                z(i+1, j-2) = z(i+1, j-2) + 3*e/48;
                z(i+1, j-1) = z(i+1, j-1) + 5*e/48;
                z(i+1, j) = z(i+1, j) + 7*e/48;
                z(i+1, j+1) = z(i+1, j+1) + 5*e/48;
                z(i+1, j+2) = z(i+1, j+2) + 3*e/48;

                z(i+2, j-2) = z(i+2, j-2) + 1*e/48;
                z(i+2, j-1) = z(i+2, j-1) + 3*e/48;
                z(i+2, j) = z(i+2, j) + 5*e/48;
                z(i+2, j+1) = z(i+2, j+1) + 3*e/48;
                z(i+2, j+2) = z(i+2, j+2) + 1*e/48;

            elseif (type == 3)
                z(i, j+1) = z(i, j+1) + 8*e/42;
                z(i, j+2) = z(i, j+2) + 4*e/42;

                z(i+1, j-2) = z(i+1, j-2) + 2*e/42;
                z(i+1, j-1) = z(i+1, j-1) + 4*e/42;
                z(i+1, j) = z(i+1, j) + 8*e/42;
                z(i+1, j+1) = z(i+1, j+1) + 4*e/42;
                z(i+1, j+2) = z(i+1, j+2) + 2*e/42;

                z(i+2, j-2) = z(i+2, j-2) + 1*e/42;
                z(i+2, j-1) = z(i+2, j-1) + 2*e/42;
                z(i+2, j) = z(i+2, j) + 4*e/42;
                z(i+2, j+1) = z(i+2, j+1) + 2*e/42;
                z(i+2, j+2) = z(i+2, j+2) + 1*e/48;      
            end            
        end    
    end
catch
    
    if ~isa(x, 'uint8')
        warning('The data type of image x is not uint8');
    elseif ~isa(algorithm, 'char')
        warning('The data type of ''algorithm'' is not char');
    elseif strcmp('fl_stein', algorithm) || strcmp('jarvis', algorithm) ...
            || strcmp('stucki', algorithm)
        warning('Algorithm is not correct');
    end
    
end       
        