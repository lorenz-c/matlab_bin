%% Programmed by Taesam Lee
%  Dec 2009, INRS-ETE, Quebec
function [biv_CDF,x_c,y_c,biv_PDF]=ecdfbiv(XD,nxbin,nybin)
%% Estimating Empirical Bivariate CDF
% XD =nL*2 matrix where nL is the record length
% nxbin = bin_number for x (default=10)
% nybin = bin_number for y (default=10)
% example 
%   XD=mvnrnd([0,0],[1,0.7;0.7,1],1000);
%   [biv_CDF,x_c,y_c]=ecdfbiv(XD,20,20)
%   surfc(x_c,y_c,biv_CDF)
nL=length(XD);
if(nargin==2)
    [N,C]=hist3(XD);
else
    [N,C]=hist3(XD,[nxbin,nybin]);
end
bin_dist(1)=(C{1}(2)-C{1}(1))/2;bin_dist(2)=(C{2}(2)-C{2}(1))/2;
biv_PDF=N/nL/(bin_dist(1)*2*bin_dist(2)*2);

x_c=C{1}+bin_dist(1);
y_c=C{2}+bin_dist(2);
sum1=0;
for i1=1:length(C{1})
    for i2=1:length(C{2})
        s1=sum(sum(N(1:i1,1:i2)));
        biv_CDF(i1,i2)=s1/nL;
    end
end
% surfc(x_c,y_c,biv_CDF)