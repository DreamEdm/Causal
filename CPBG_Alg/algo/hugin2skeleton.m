function [ skeleton,names ] = hugin2skeleton( file )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fid=fopen(file);
frewind(fid);
%%%%%%%%%%%%%%%%%%%%��Ҫ�ڵ�������ʼ��skeleton%%%%%%%%%%%%%%%%%
k=0;
while ~feof(fid) % �ж��Ƿ�Ϊ�ļ�ĩβ
    tline=fgets(fid); % ���ļ�����һ���ı��������س�����
    if ~isempty(tline) % �ж��Ƿ����
        [~,n]=size(tline);
        if n>=4
            pipei=tline(1:4);
        elseif strcmp(pipei,'node')
            k=k+1;
        end
    end
end
skeleton=zeros(k,k);
%%%%%%%%%%%%%%%%%%%���ڵ�����%%%%%%%%%%%%%%%%%
j=0;
frewind(fid)
while ~feof(fid)
    tline=fgets(fid);
    [~,n]=size(tline);
    pipei=tline(1,1:end);
    stop='potential';
    if  regexpi(pipei,stop)
        break
    end
    if n>=4
        yuchu=tline(1,1:end);
        pipei=yuchu(1:4);
        if strcmp(pipei,'node')
            pa='node.*\w';
            na=regexp(yuchu,pa,'match');
            if ~isempty(na)
                j=j+1;
                na= char(na);
                na=strrep(na,' ','');
                names{j}=strrep(na,'node','');
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%����sketelon���%%%%%%%%%%%%%%%%%
frewind(fid)
while ~feof(fid)
    tline=fgets(fid);
    [~,n]=size(tline);
    if n>=6
        yuchu=tline(1,6:end);
        pat='\| ';
        if regexp(yuchu,pat)
            pa='\|.*\w';
            A=regexp(yuchu,pa,'match');
            A=strrep(A,'|','');
            A= regexp(A,'\s+','split');
            if ~isempty(A)
                A=A{1};
            end
            pa='\(.*\|';
            B=regexp(yuchu,pa,'match');
            B=strrep(B,'|','');
            B=strrep(B,'(','');
            B=strrep(B,' ','');
            len=length(A);
            for n=1:len
                if ~isempty(A{n})
                    inda=strcmp(names,A{n});
                    f= inda==1;
                indb=strcmp(names,B);
                z= indb==1;
                skeleton(f,z)=1;
                end
            end
        end
    end
end
%graphViz4Matlab('-adjMat',skeleton,'-nodeLabels',names,'-layout',Treelayout)
end

