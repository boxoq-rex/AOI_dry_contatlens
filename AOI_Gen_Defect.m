% AOI_Gen_Defect: Generates defects
clc; clear all; close all;

%% Definition
% Number of generated images = 
% NUM_LOOP*(DEGREE_END-DEGREE_START)/DEGREE_INTERVAL
% (DEGREE_END - DEGREE_START + 1) = N*DEGREE_INTERVAL where N is an integer.
NUM_LOOP = 1; 
DEGREE_START = 0;   
DEGREE_END = 0;
DEGREE_INTERVAL = 45;
CROP_SIZE = 150; % Size of each generated defect image (Even number)

%% Read perfect contact lense image
% Write the path of the image
pathd = 'img\';
num_imgs = length(dir([pathd '*.jpg']));
img_dir = dir([pathd '*.jpg']);

% Read the image of the perfect contact
for d = 1:num_imgs          % Count for number of perfect images to read
    img_obj = img_dir(d);   % Read No.d image object
    img_ori_rgb = imread([pathd img_obj.name]);
    img_ori = rgb2gray(img_ori_rgb);
    [img_size_y img_size_x] = size(img_ori); 
    % figure, imshow(img_ori); % Test for img_ori 
    
    % Find the center of the lense in a given perfect image
    % [?] Need to modify the function for calculating the center and the 
    % radius of the given image of perfect contact
    xc = 659.2985*1.75;
    yc = 584.7214*1.75;
    rc = 544.1864*1.75;
    
    for i = 1:NUM_LOOP % See Definition
        for j = DEGREE_START:DEGREE_INTERVAL:DEGREE_END % See Definition
        
        %% Generate the start and end point of the generated defects
        % (START_POINT, END_POINT) where START_POINT < END_POINT
        END_POINT = unidrnd(CROP_SIZE,1,1);
        if END_POINT < 2  
           END_POINT = 2;
        end
        START_POINT = unidrnd(END_POINT-1,1,1);    
            
        %% Crop CROP_SIZExCROP_SIZE-images from img_ori
        % For example, 150x150-image
        
        % Definition of BBOX coordination
        CROP_IMG_X = xc + rc*cos(2*pi*j/360) - CROP_SIZE/2;
        CROP_IMG_Y = yc - rc*sin(2*pi*j/360) - CROP_SIZE/2;
        
        
        % Modification for out-of-range situation
        ORI_IMG_X = img_size_x; 
        ORI_IMG_Y = img_size_y;
        EDGE_DEL_X = abs(CROP_IMG_X + CROP_SIZE - ORI_IMG_X);
        EDGE_DEL_Y = abs(CROP_IMG_Y + CROP_SIZE - ORI_IMG_Y);
        
        % Check if CROP_IMG_X is out-of-range
        if CROP_IMG_X + CROP_SIZE > ORI_IMG_X
            CROP_IMG_X = CROP_IMG_X - EDGE_DEL_X;
        elseif CROP_IMG_X < 0
            CROP_IMG_X = 0;
        end        

        % Check if CROP_IMG_Y is out-of-range
        if CROP_IMG_Y + CROP_SIZE > ORI_IMG_Y
            CROP_IMG_Y = CROP_IMG_Y - EDGE_DEL_Y;
        elseif CROP_IMG_Y < 0
            CROP_IMG_Y = 0;
        end
        %% Generate defect on the edge
        img_SIM = img_ori;
        if j <= 45 || (j < 360 && j >= 315)
            for y = START_POINT : END_POINT 
                % Start to check from the points within the circle
                if abs(floor(CROP_IMG_Y) - yc) <= rc
                    % x position given y position
                    x_defect_start = 4 + floor(sqrt(rc^2-(floor(CROP_IMG_Y) - yc)^2) + xc);
                    
                    % Random number of edge pixel
                    EDGE_NUM = 2 + unidrnd(2,1,1);
                    
                    % Generate pattern on the edge
                    for x = x_defect_start : x_defect_start+EDGE_NUM-1
                        RANGE = x;
                        if RANGE - CROP_IMG_X > CROP_SIZE 
                            RANGE = CROP_SIZE;
                        elseif RANGE - CROP_IMG_X < 0 
                            RANGE = 1;
                        end
                    
                        img_SIM(floor(CROP_IMG_Y)+y,RANGE) = 135+ unidrnd(15,1,1);
                        
                    end % x
                    MIN_POINT(y-START_POINT+1) = x_defect_start;
                    MAX_POINT(y-START_POINT+1) = x_defect_start+EDGE_NUM-1;
                
                end % if    
                
            end % y
            
            
            % Create bbox
            bbox_x_0 = min(MIN_POINT);
            bbox_y_0 = floor(CROP_IMG_Y) + START_POINT;
            bbox_x_1 = max(MAX_POINT);
            bbox_y_1 = floor(CROP_IMG_Y) + END_POINT;
            
        else
            
        end
  
        
        % Crop a CROP_SIZExCROP_SIZE image from the original image
        img_crop = imcrop(img_SIM,[CROP_IMG_X CROP_IMG_Y 149 149]);
        figure, imshow(img_crop);
        %Test: comparing the img_crop and img_ori
        bbox_test = [bbox_x_0-CROP_IMG_X bbox_y_0-CROP_IMG_Y bbox_x_1-bbox_x_0 bbox_y_1-bbox_y_0];
        img_test = insertShape(img_crop,'Rectangle',bbox_test,'LineWidth',1, 'Color', 'yellow');
        figure, imshow(img_test); 
        write_file = strcat(sprintf('%06d',1));
        imwrite(img_crop, [write_file,'.png']);

        
        
         
            
        end % j
    end % i

end % d





