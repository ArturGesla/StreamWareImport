function [V,amp,Z]=zna2019(nazwa)
%% dane charakterystyczne pomiaru
fftcalc=0;
xt=0;
fpc=0;
fid=fopen(nazwa,'r');
control=0;
while(control~=1)
t=fgetl(fid);
if (length(t)>19) if (t(1:19)=='Number of positions') control=1; end; end
end
npos=t;
%przeliczenie na wartoœci
    m=0;
    for i=1:length(npos)-21
        m=m+(double(npos(length(npos)-i+1))-48)*10^(i-1);
    end
    %%
for j=1:m
    ctr=1;
%[F(j),L(j),z(j)]=look_for_values();
control=0;
while(control~=1)
t=fgetl(fid);
if (length(t)>15) if (t(1:15)=='(mm,mm,mm,deg):') control=1; end; end
end
z{j}=t;%<---------
control=0;
while(control~=1)
t=fgetl(fid);
if (length(t)>17) if (t(1:17)=='Sample freq.,kHz:') control=1; end; end
end
freq=t;%<---------
ns=fgetl(fid);%<---------
%przeliczenie na wartoœci
    frequency=0;
    len=0;
    for i=1:length(freq)-20
        frequency=frequency+(double(freq(length(freq)-i+1))-48)*10^(i-1);
    end
    for i=1:length(ns)-20
        len=len+(double(ns(length(ns)-i+1))-48)*10^(i-1);
    end
    
    L(j)=len;
    F(j)=frequency*1e3;
    Z(j)=get_z(z{j});
control=0;
while(control~=1)
t=string(fgetl(fid));
if (t==strcat('[DATA BLOCK 1-',string(j),'-1]')) control=1; end
end
        A(:,:,j) = fscanf(fid,'%f %f %f',[3 L(j)]); 
       if (j/m*100>10*ctr) fprintf('.'); ctr=ctr+1; end
end
fclose('all');
V=A;
%assignin('base','L',L);
%assignin('base','F',F);
amp=nan;
end
function [F,L,z]=look_for_values()
control=0;
while(control~=1)
t=fgetl(fid);
if (length(t)>15) if (t(1:15)=='(mm,mm,mm,deg):') control=1; end; end
end
z=t;%<---------
control=0;
while(control~=1)
t=fgetl(fid);
if (length(t)>17) if (t(1:17)=='Sample freq.,kHz:') control=1; end; end
end
freq=t;%<---------
ns=fgetl(fid);%<---------
%przeliczenie na wartoœci
    frequency=0;
    len=0;
    for i=1:length(freq)-20
        frequency=frequency+(double(freq(length(freq)-i+1))-48)*10^(i-1);
    end
    for i=1:length(ns)-20
        len=len+(double(ns(length(ns)-i+1))-48)*10^(i-1);
    end
    L=len;
    F=frequency*1e3;

end

% if (xt==1)
%     for i=1:F
%     end
%     mkdir xt;
% pliki=fopen('ppng.txt','r');
% for i=1:m
% hfig=figure;
% set(hfig, 'Visible', 'off');
% plot(t,A(2,:,i));
% print(hfig,'-dpng',fgetl(pliki));
% disp(i/m*100);
% disp('% completed');
% close(hfig);
% end
% fclose(pliki);
% disp('xt completed');
% end
% f=(0:L-1)/L*F;
% assignin('base','f',f);
% if (fftcalc==1)
% z(m,L)=0;
% amp(m,L)=0;
% for j=1:m
% z(j,:)=fft(A(2,:,j));
% amp(j,:)=2*abs(z(j,:)/L);
% avg(j)=mean(A(2,:,j));
% end
% assignin('base','amp',amp);
% disp('fft calc completed');
% end
% if (fpc==1)
%     mkdir fft;
% pliki=fopen('pfft.txt','r');
% for j=1:m
%     hfig=figure;
% set(hfig, 'Visible', 'off');
% plot(f(2:end/2),amp(j,2:end/2));
% print(hfig,'-dpng',fgetl(pliki));
% disp(j/m*100);
% disp('% completed');
% close(hfig);
% end
% fclose(pliki);
% assignin('base','amp',amp);
% disp('fft png completed');
% end