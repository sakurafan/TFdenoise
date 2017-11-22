hold on;%多条曲线画在一张图上
box on;%显示上方和右方的坐标刻度

% a = [1, 5; 4, 6; 7, 9];
x=[3,8,10,15,20];
y1=[6.92,12.06,12.50,12.07,11.10];
y2=[0.15,0.38,0.92,0.64,0.44];
y3=[0.22,0.58,1.85,1.33,0.86];
y4=[10.26,13.08,13.72,13.12,11.79];

plot(x,y1,'b-o');

hold on;
plot(x,y2,'r-*');
hold on;
plot(x,y3,'k-+');
hold on;
plot(x,y4,'g-s');

legend('NonLocal-Tensor-4','Rand-Tensor-4','Rand-Tensor-5', 'NonLocal-Tensor-5','Location', 'SouthEast');%标注这条线，标注位置是东南角

xlabel('principle component');%x轴标注
ylabel('ISNR');%y轴标注

