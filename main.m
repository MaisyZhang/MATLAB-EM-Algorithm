close all; clc; clear all;

% 生成数据
R1 = mvnrnd([1, 2.25], [1.75, 1;1,1.75], 30);
R2 = mvnrnd([12.9,10.3],[3.2,1.25;1.25,3.2],70);

Y=[R1;R2];
plot(R1(:,1), R1(:,2),'ro'); hold on;
plot(R2(:,1),R2(:,2),'bo');hold on;

% 用多高斯来拟合,高斯数目为2
M = 2;
% 迭代300次
T = 300;
% 用EM算法来进行迭代
[alpha, mu, sigma] = EMM(Y, M, T);

% 看结果
m1 = 1; % 第一个高斯
m2 = 2; % 第二个高斯
color={'r', 'b'};
error_ellipse(sigma(:,:,m1), mu(m1,:)', 'style', color{m1}); hold on
error_ellipse(sigma(:,:,m2), mu(m2,:)', 'style', color{m2}); hold on

