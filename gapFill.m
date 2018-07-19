% ------------------------------------------------------------------------
% Purpose : gap fill from tides observation
%
% Input   : index blank data, time, tides
%
% Output  : time, tides
%
% Routine : -
%
%
% Hollanda arief kusuma
%
% 12-Jul-2018: First created - HAK
% ------------------------------------------------------------------------

function [tipe, waktu, tides]=gapFill(id,dates,tide,Tobs)
n=length(id);
len=length(tide);
j=1;
tides=[];
waktu=[];
tipe=[];

for i=1:n%:-1:29
    k=id(i);
    m=k-j+1;
%    cuplik data di rentang data kosong
     t=datenum(dates(id(i)-20:id(i)+20));
     l=tide(id(i)-20:id(i)+20);
    %interpolasi
    f= fit(t,l,'pchipinterp');%pchipinterp
    %generate data di rentang waktu kosong
    t1=datenum(dates(id(i))):Tobs:datenum(dates(id(i)+1));
    l1=feval(f,t1);
    l1(1)=[];
    t1(1)=[];
    l1(length(l1))=[];
    t1(length(t1))=[];
    tides=[tides;tide(j:k);l1];
    waktu=[waktu;dates(j:k);datetime(datevec(t1))];
    tipe=[tipe; repmat('observed',m,1); repmat('gap fill',length(l1),1)];
    j=k+1;
end

tides=[tides;tide(j:len)];
waktu=[waktu;dates(j:len)];
tipe=[tipe;repmat('observed',len-j+1,1)];
tipe=cellstr(tipe);
