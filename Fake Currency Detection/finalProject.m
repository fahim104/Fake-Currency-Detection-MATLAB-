%% //Read in images
%clear all;
%close all;

%% //Get the entered image location
fid = fopen('imageLoc.txt','r');
imageLocImage = fgetl(fid);

%% //Get the selected note type 
I = imread(imageLocImage);
fid = fopen('noteType','r'); % fid = file identifier
note = fgetl(fid);

%% //Extract the black strips for each image
if (strcmp(note,'100'))
    blackStrip = I(:,39:48,:);
else % if note == 500
    blackStrip = I(:,35:45,:);
end


% //Resize so that we have the same dimensions as the other images
%Ifake2 = imresize(Ifake2, [160 320], 'bilinear');

%% //Convert into grayscale then threshold
blackStrip = rgb2gray(blackStrip);


%% //Threshold using about intensity 30
blackStrip2BW = ~im2bw(blackStrip, 30/255);


%% //Area open the image
%figure(4);
areaopenReal2 = bwareaopen(blackStrip2BW, 100);


%% //Post-process
se = strel('square', 5);
BWImageCloseReal2 = imclose(areaopenReal2, se);


%% //Count the total number of objects in this strip
[~,countObj] = bwlabel(BWImageCloseReal2);
disp(['The total number of black lines for the note is: ' num2str(countObj)]);

%{
  //The total number of black lines for the real note will be 1
  //The total number of black lines for the fake note will be more than 1
%}
fid = fopen('verdict.txt','wt');
if (countObj) == 1
    fprintf(fid, 'Real');
else
    fprintf(fid, 'Fake');
end