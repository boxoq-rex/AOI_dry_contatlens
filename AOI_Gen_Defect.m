% AOI_Gen_Defect: Generates defects
clc; clear all; close all;

%% Definition
% Number of generated images = 
% NUM_LOOP*(DEGREE_END-DEGREE_START)/DEGREE_INTERVAL
% (DEGREE_END - DEGREE_START + 1) = N*DEGREE_INTERVAL where N is an integer.
NUM_LOOP = 1; 
DEGREE_START = 0;   
DEGREE_END = 59;
DEGREE_INTERVAL = 1; 

%% Read perfect contact lense image
% Write the path of the image
pathd = 'img\';
num_imgs = length(dir([pathd '*.jpg']));
img_dir = dir([pathd '*.jpg']);

% Read the image of the perfect contact
for d = 1:num_imgs          % Count for number of perfect images to read
    img_obj = img_dir(d);   % Read No.d image object
    img_ori = imread([pathd img_obj.name]);
    figure, imshow(img_ori);
    
    % Find the center of the lense in a given perfect image
    % [?] Need to modify the function for calculating the center and the 
    % radius of the given image of perfect contact
    xc = 659.2985*1.75;
    yc = 584.7214*1.75;
    rc = 544.1864*1.75;
    
    for i = 1:NUM_LOOP % See Definition
        for j = DEGREE_START:DEGREE_INTERVAL:DEGREE_END % See Definition
            
            
            
        end % j
    end % i

end % d





