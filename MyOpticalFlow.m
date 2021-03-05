function [ x, y, vx, vy ] = MyOpticalFlow( Ic, Il, N )
%MYOPTICALFLOW calculates the optical flow
%   [ x, y, vx, vy ] = MyOpticalFlow( Ic, Il, N )
%   x, y are row vector contain the coordinates of the domain of the flow
%   vector field
%   vx, vy are matrices containing the flow vector components
%   The inputs are the current grayscale image Ic, the last grayscale
%   image Il and the side length N of the local area Q.
%% Calculate the vectors x and y containing 
% [rows ,columns ,numberOfColorBands] = size(Ic);
% Divide the image up into blocks.
% we know the block size which is N and that all blocks will be the same size
blockSizeR = N; % Rows in block.
blockSizeC = N; % Columns in block.
% the coordinates of the middle points of the local areas. 
[x,y] = meshgrid(N/2:N:floor(size(Ic,2)/N)*N,N/2:N:floor(size(Ic,1)/N)*N); 
% Initialize the matrices vx and vy with zeros.
vx = zeros(size(x,1),size(x,2));
vy = zeros(size(y,1),size(y,2));
% Calculate the spatial gradients of the current image using the Prewitt operator.
[Gx, Gy] = imgradientxy(Ic,'prewitt');
% Estimate the temporal gradient
temporalGradient = Ic - Il;
%% For every local area
% Now scan through, getting each block
sliceNumber = 1;
for col = 1 : blockSizeC : floor(size(Ic,2)/N)*N
  for row = 1 : blockSizeR : floor(size(Ic,1)/N)*N

    row1 = row;
    row2 = row1 + blockSizeR - 1;
    col1 = col;
    col2 = col1 + blockSizeC - 1;
    
    v = [];
    i = 1;

    for l = col1:col2
        for k = row1:row2
            A(i,:)= [Gx(k,l) Gy(k,l)];
            h(i,:) = - temporalGradient(k,l);
            i = i+1;
        end
    end
    v = pinv(A) * h;
%     if (v(1,1) ~= 0 || v(2,1) ~= 0)
%         vx1(sliceNumber) = v(1,1)-0.106;
%         vy1(sliceNumber) = v(2,1)-0.183;
%     else
        vx1(sliceNumber) = v(1,1);
        vy1(sliceNumber) = v(2,1);
%     end
    sliceNumber = sliceNumber + 1;
    % sliceNumber
    
  end
end
%%
% save flow vector components
flowVectorSize_x = floor(size(Ic,1)/N);
flowVectorSize_y = floor(size(Ic,2)/N);
vx = reshape(vx1,flowVectorSize_x,flowVectorSize_y);
vy = reshape(vy1,flowVectorSize_x,flowVectorSize_y);