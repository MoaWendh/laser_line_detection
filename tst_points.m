clc;
clear all;

path= '\images\CloudPoints\points.txt';
a=load('.\images\CloudPoints\points.txt');
a= 1000*a;

name_file= sprintf('.\\images\\CloudPoints\\pts.txt');
fid = fopen(name_file,'wt');  
fprintf(fid,'%5.2f %5.2f %5.2f\r\n', a');
fclose(fid);