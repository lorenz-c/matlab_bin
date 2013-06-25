function [Imputed_data]=DataImpute(Data,method)

% mathod: 1 : monthly mean
%         2 : interpolation

% Data format: first column : year
%              Second column : month
% The value should be started from third column (there is no limitation in number of columns)

[row col]=size(Data);
Imputed_data=Data;

%% Imputing the mean monthly values to NaN values 
if method==1
    f1=find(Data(:,2)==1);f2=find(Data(:,2)==2);
    f3=find(Data(:,2)==3);f4=find(Data(:,2)==4);
    f5=find(Data(:,2)==5);f6=find(Data(:,2)==6);
    f7=find(Data(:,2)==7);f8=find(Data(:,2)==8);
    f9=find(Data(:,2)==9);f10=find(Data(:,2)==10);
    f11=find(Data(:,2)==11);f12=find(Data(:,2)==12);
    Jan1=zeros(1,col-2); Feb1=zeros(1,col-2); Mar1=zeros(1,col-2);
    Apr1=zeros(1,col-2); May1=zeros(1,col-2); Jun1=zeros(1,col-2);
    Jul1=zeros(1,col-2); Aug1=zeros(1,col-2); Sep1=zeros(1,col-2);
    Oct1=zeros(1,col-2); Nov1=zeros(1,col-2); Dec1=zeros(1,col-2);
    M_Data=zeros(12,col-2);

    for i=3:col
        Jan1(1,i-2)=mean(Data(f1(find(isnan(Data(f1,i))==0)),i));Feb1(1,i-2)=mean(Data(f2(find(isnan(Data(f2,i))==0)),i));
        Mar1(1,i-2)=mean(Data(f3(find(isnan(Data(f2,i))==0)),i));Apr1(1,i-2)=mean(Data(f4(find(isnan(Data(f4,i))==0)),i));
        May1(1,i-2)=mean(Data(f5(find(isnan(Data(f5,i))==0)),i));Jun1(1,i-2)=mean(Data(f6(find(isnan(Data(f6,i))==0)),i));
        Jul1(1,i-2)=mean(Data(f7(find(isnan(Data(f7,i))==0)),i));Aug1(1,i-2)=mean(Data(f8(find(isnan(Data(f8,i))==0)),i));
        Sep1(1,i-2)=mean(Data(f9(find(isnan(Data(f9,i))==0)),i));Oct1(1,i-2)=mean(Data(f10(find(isnan(Data(f10,i))==0)),i));
        Nov1(1,i-2)=mean(Data(f11(find(isnan(Data(f11,i))==0)),i));Dec1(1,i-2)=mean(Data(f12(find(isnan(Data(f12,i))==0)),i));
    end
    
    M_Data=[Jan1;Feb1;Mar1;Apr1;May1;Jun1;Jul1;Aug1;Sep1;Oct1;Nov1;Dec1];
    
    
    [m,n]=find(isnan(Data)==1);
    for i=1:length(m)
        Imputed_data(m(i),n(i))=M_Data(Data(m(i),2),n(i)-2);
    end
end

%% Interpolation
if method==2
    [m n]=find(isnan(Data)==1);
    for i=1:length(m)
        Imputed_data(m(i),n(i))=(Data(m(i)-1,n(i))+Data(m(i)+1,n(i)))/2;
    end
end