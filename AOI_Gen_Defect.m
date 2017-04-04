% AOI_Gen_Defect: Generates defects
clc; clear all; close all;

% Definition

% == Read perfect contact lense image ==
% Write the path of the image
pathd = 'img\';
num_imgs = length(dir([pathd '*.jpg']));
img_dir = dir([pathd '*.jpg']);

% Read the image of the perfect contact
for d = 1:num_imgs
    img_obj = img_dir(d); % Read No.d image object
    img_ori = imread([pathd img_obj.name]);
    figure, imshow(img_ori);
end


% Find the center of the lense in a given perfect image
% [?] Need to modify the function for calculating the center and the radius
% of the given image of perfect contact
xc = 659.2985*1.75;
yc = 584.7214*1.75;
rc = 544.1864*1.75;


