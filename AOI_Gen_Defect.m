% AOI_Gen_Defect: Generates defects
clc; clear all; close all;

%% Definition
% Number of generated images = 
% NUM_LOOP*(DEGREE_END-DEGREE_START)/DEGREE_INTERVAL
% (DEGREE_END - DEGREE_START + 1) = N*DEGREE_INTERVAL where N is an integer.
NUM_LOOP = 1; 
DEGREE_START = 0;   
DEGREE_END = 44;
DEGREE_INTERVAL = 1;
CROP_SIZE = 150; % Size of each generated defect image (Even number)

%% Read perfect contact lense image
% Write the path of the image
pathd = 'img\';
num_imgs = length(dir([pathd '*.jpg']));
img_dir = dir([pathd '*.jpg']);

% Read the image of the perfect contact
for d = 1:num_imgs          % Count for number of perfect images to read
    img_obj = img_dir(d);   % Read No.d image object
    img_ori = imread([pathd img_obj.name]);
    [img_size_x img_size_y img_size_z] = size(img_ori); 
    % figure, imshow(img_ori); % Test for img_ori 
    
    % Find the center of the lense in a given perfect image
    % [?] Need to modify the function for calculating the center and the 
    % radius of the given image of perfect contact
    xc = 659.2985*1.75;
    yc = 584.7214*1.75;
    rc = 544.1864*1.75;
    
    for i = 1:NUM_LOOP % See Definition
        for j = DEGREE_START:DEGREE_INTERVAL:DEGREE_END % See Definition
        
        % Generate the start and end point of the generated defects
        % (START_POINT, END_POINT) where START_POINT < END_POINT
        END_POINT = unidrnd(CROP_SIZE,1,1);
        if END_POINT < 2  
           END_POINT = 2;
        end
        START_POINT = unidrnd(END_POINT-1,1,1);    
            
        % Crop CROP_SIZExCROP_SIZE-images from img_ori
        % For example, 150x150-image
        
        % Definition of BBOX coordination
        CROP_IMG_X = xc + rc*cos(2*pi*j/360) - CROP_SIZE/2;
        CROP_IMG_Y = yc - rc*sin(2*pi*j/360) - CROP_SIZE/2;
        % Modification for out-of-range situation
        ORI_IMG_X = img_size_x; % haven't define yet ***
        ORI_IMG_Y = img_size_y; % haven't define yet ***
        EDGE_DEL_X = abs(CROP_IMG_X + CROP_SIZE - ORI_IMG_X);
        EDGE_DEL_Y = abs(CROP_IMG_Y + CROP_SIZE - ORI_IMG_Y);
        
        %Test
        CROP_IMG_X = 2000;
        
        if CROP_IMG_X + CROP_SIZE > ORI_IMG_X
            CROP_IMG_X = CROP_IMG_X - EDGE_DEL_X;
        elseif CROP_IMG_X < 0
            CROP_IMG_X = 0;
        end
            
        end % j
    end % i

end % d





