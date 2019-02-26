function z=get_z(str)
a=str(22:end-2);
z=0;
n=1;
pos=0;
for i=1:length(a)
    if (double(a(i))~=46) b(n)=(a(i)-48); n=n+1; else pos=i; end
end
for i=1:length(b)
   z=z+b(i)*10^(length(b)-i); 
end
if (pos>0) z=z/10^(length(a)-pos); end
end
