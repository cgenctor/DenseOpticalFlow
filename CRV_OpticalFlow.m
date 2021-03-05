%% CRV_22_OpticalFlow
% name : Candas Genctor

%% clean up 
clear;
close all
clc;
%% first sequence
% for every image in the sequence, load the image and convert it to double
b=cell(43,1);
c=cell(43,1);
for i=1:size(c,1)
    b{i}=imread(sprintf('image_%d.png',i));     % Load the image
    c{i} = double(b{i});    
end
% for the second till the last image
for m = 2:size(c,1)
    Ic = c{m};
    Il = c{m-1};
    % fN = 'opticalFlowResult';
    fN = sprintf('1stSeqOpticalFlowResultOf %d',m-1);
    sF = 1;
    N = 40;
    [x,y,vx,vy] = MyOpticalFlow( Ic, Il, N );
    I = b{m-1};
    MyOpticalFlowVisualization( I, x, y, vx, vy, sF, fN);
end
%% second sequence
b=cell(50,1);
c=cell(50,1);
for i=1:size(c,1)
    b{i}=imread(sprintf('image_%d.png',i));     % Load the image
    RGB = b{i};
    grayImg = rgb2gray(RGB);
    c{i} = double(grayImg);   
end
% for the second till the last image
for m = 2:size(c,1)
    Ic = c{m};
    Il = c{m-1};
    % fN = 'opticalFlowResult';
    fN = sprintf('2rdSeq_OpticalFlowResultOf_%d',m-1);
    sF = 1;
    N = 30;
    [ x, y, vx, vy ] = MyOpticalFlow( Ic, Il, N );
    I = b{m-1};
    MyOpticalFlowVisualization( I, x, y, vx, vy, sF, fN);
end

