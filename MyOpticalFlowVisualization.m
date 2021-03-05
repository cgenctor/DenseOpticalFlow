function [ ] = MyOpticalFlowVisualization( I, x, y, vx, vy, sF, fN)
%MYOPTICALFLOWVISUALIZATION saves visualization of optical flow
%   MyOpticalFlowVisualization( I, x, y, vx, vy, fN, sF) shows the image I
%   and visualizes the optical flow with components vx and vy and the
%   coordinates x and y. The plot of the flow vectors is auto scaled with
%   the scale factor sF. The resulting figure is saved as a png image file
%   named fN.

figure % create a figure
imshow(I)  % show the image
hold on
quiver(x,y,vx,vy,sF,'r');  % plot the flow vectors 
filename = fN; % save the figure using filename fN and close it
print(filename,'-dpng')
close
end
