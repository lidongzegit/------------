%% 李东泽 2021-09-24
close all
clear
clc
%% 有限差分作业1-4
a = 10;
b = 15;
phi = 200;
h = 0.01;% 步长，单位：cm
n0 = 20;
nm = 10000;
er0 = 1e-2;
erm = 1e-4;
l = a/h;
m = b/h;
jm = a/h+1;
im = b/h+1;
for j = 1:jm
    for i = 1:im
        Up(i,j) = 0;
    end
end

w = 1;
for n = 1:nm
    fprintf('%d\n',n);
    for j = 1:jm
        for i = 1:im
            if j==1
                Un(i,j) = 0;
            else if i==im
                    Un(i,j) = phi;
                else if j==jm
                        Un(i,j) = phi;
                    else if i==1
                            Un(i,j) = Up(i,j)+w*(Up(i+1,j)-Up(i,j));
                        else
                            Un(i,j) = Up(i,j)+w/4*(Up(i+1,j)+Up(i,j+1)+Un(i-1,j)+Un(i,j-1)-4*Up(i,j));
                        end
                    end
                end
            end
        end
    end
    ER = abs(Un-Up);
    er = max(max(ER));
    if (n>n0)&&(er>er0)
        w = 2-sqrt(2*pi*(1/l^2+1/m^2));
    end
    if er < erm
        break
    end
    Up = Un;
end
imagesc(Up);
axis equal;
xlim([0 1000]);
ylim([0 1500]);