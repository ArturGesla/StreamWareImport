clearvars;
for i=1:1
s(i)=strcat(string('40.txt'));
%lg(i)=strcat(string(50+(i-1)*5),string(' Hz'));
%lgR(i)=strcat(string('Re='),string(round(0.075*sqrt((50+(i-1)*5)*2*pi/ni))));
end
%%
fprintf('==== Start ====\n'); 
for i=1:length(s)
nazwa=s(i);
[V,amp,z]=zna2019(nazwa);
AMP(:,:,i)=amp;
[h b l]=size(V);
for j=1:l
    for k=1:b
B(j,k,i)=V(2,k,j);
    end
end
A{i}=B(:,:,i);
Z{i}=z(:)';
fprintf('%4.2f %% files completed \n',i/length(s)*100); 
end
clearvars -except A Z s;
fprintf('==== End ====\n'); 
