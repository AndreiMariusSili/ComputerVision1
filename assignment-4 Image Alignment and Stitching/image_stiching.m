%% question 1.1
clear;
clc;

left = rgb2gray(imread('left.jpg'));
right = rgb2gray(imread('right.jpg'));

stitched = stitch(left, right);