clear all
close all

load('Out.mat'); % load the prepared grey dataset
data = dataN; % copy the dataN variable that contains the dataset to ram
[dataRow, dataCol] = size(data);

prompt = {'Which column(s) are inputs','Which column(s) are outputs','% For Testing','How many nodes in hidden layer','Number of Iterations'};
dlg_title = 'Network parameters';
num_lines = [1 50];
answer = inputdlg(prompt,dlg_title,num_lines);
choice = questdlg('Draw the network?','Draw network','Yes','No','No');
in_arr = str2num(answer{1});
in = size(in_arr,2)
out_arr = str2num(answer{2});
out = size(out_arr,2)
mid =str2num(answer{4}); %mid=enter number of hidden layer nodes
tstPrcnt= str2num(answer{3});
reMax = str2num(answer{5});

% enter the percentage of data you want to use for testing the network
tstSize = size(data,1)*tstPrcnt/100;
trnSize = size(data,1)-tstSize;

data1 = data(1:40,:);
data2 = data(41:80,:);
data3 = data(81:120,:);

data1 = data1(randperm(size(data1, 1)), :);
data2 = data2(randperm(size(data2, 1)), :);
data3 = data3(randperm(size(data3, 1)), :);

data_t = [data1(1:trnSize/3,:);data2(1:trnSize/3,:);data3(1:trnSize/3,:)];

data_t = data_t(randperm(size(data_t, 1)), :);
wih = (rand(mid,in)*(2/sqrt(in)))-(1/sqrt(in));
woh = (rand(out,mid)*(2/sqrt(mid)))-(1/sqrt(mid));

% best model weights:
% wih =[3.199625990073471 -10.894295552091233
%   -2.327675863942786   5.486104786281468
%    4.792866125550718 -12.436351917538715];
% woh =[64.411059259911596  -4.843789868267247  64.124360684879335];

v=0;
lamda = 0.9;
alpha = 0.1;
deltaWp1 = zeros(out,mid);
deltaWp2 = zeros(mid,in);
% deltaWp1 =[0.000092034292166  -0.004597258002348   0.000100251566907];
% deltaWp1 = deltaWp1* 1.0e-03;
% deltaWp2 =[0.001178327668382   0.000837471938221
%    0.001764445491413   0.001764278834658
%    0.001268520230798   0.000901659308154];
% deltaWp2 =deltaWp2 *1.0e-04;

tic
errT=zeros(1,reMax);
for re = 1:reMax
    for s = 1:trnSize
        xs = data_t(s,in_arr).';
        th = wih*xs;
        oh = 1./(1+exp(-th));
        to = woh*oh;
        oo = 1/(1+exp(-to));
        
        err = data_t(s,out_arr)-oo;
        sigma = oo*(1-oo)*err;
        
        for i = 1:mid
            deltaW1(i)= lamda*sigma*oh(i)+alpha*deltaWp1(i);
            sigmaM(i) = oh(i)*(1-oh(i))*((woh(i))*sigma);
        end
%         alternative update formulas
%         for i = 1:mid
%             deltaW1= lamda*sigma*oh.'+alpha*deltaWp1;
%             sigmaM = ((oh.*(1-oh)).').*(woh*sigma);
%         end
        
        for i = 1:in
            for j = 1:mid
                deltaW2(j,i)= lamda*sigmaM(j)*xs(i)+alpha*deltaWp2(j,i);
            end
        end
%         another update formula
%         for i = 1:in
%             deltaW2(:,i)= lamda*sigmaM(:)*xs(i)+alpha*deltaWp2(:,i);
%         end
        wih = wih+deltaW2;
        woh = woh+deltaW1;
        deltaWp1 = deltaW1;
        deltaWp2 = deltaW2;
        if s>1
            errT(re) = errT(re)+abs(err);
        end
    end
    errT(re)=errT(re)/trnSize;
    re
end
plot(errT)
toc

data_c = [data1(trnSize/3+1:end,:);data2(trnSize/3+1:end,:);data3(trnSize/3+1:end,:)];

data_c = data_c(randperm(size(data_c, 1)), :);

v_c=0;
for s = 1:tstSize
    xs = data_c(s,in_arr).';
    th = wih*xs;
    oh = 1./(1+exp(-th));
    to = woh*oh;
    oo = 1/(1+exp(-to))
    err = data_c(s,out_arr)-oo;
    var_o(s)=oo;
    var_c(s)=err;
end

figure(2);
plot(var_c);
xlabel('Sample');
ylabel('Error');
title('Output Error');

figure(3);
plot(var_o);

var_b = 0.3*ones(1,tstSize);
for i=1:tstSize
    if (abs(var_c(i)) <0.3)
        var_b(i) = data_c(i,out_arr);
    end
end

var_bCat = categorical(cellstr(num2str(var_b.')),{'0' '0.3' '0.5' '1'},{'Cheeta' 'Incorrect' 'Leopard' 'Lioness'});
figure(3);
h=histogram(var_bCat);
% accuracy=(h.Values(1)+h.Values(3))/20
accuracy=(h.Values(1)+h.Values(3)+h.Values(4))/(tstSize)*100


