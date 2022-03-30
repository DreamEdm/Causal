function [skeleton,names] = net2sketelon( file)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

fid=fopen(file);
%%%%%%%%%%%%%%%%%%%%需要节点数，初始化skeleton%%%%%%%%%%%%%%%%%
k=0;
while ~feof(fid) % 判断是否为文件末尾
    tline=fgets(fid);% 从文件读入一行文本（不含回车键）
    tline= strrep(tline,'''','');
    if ~isempty(tline) % 判断是否空行
        [~,n]=size(tline);
        if n>=4
            %             pipei=tline(2:3);
            yuchu=tline(1,1:end);
            pi=yuchu(1,2:4);
            if strcmp(pi,'var')==1
                k=k+1;
            end
        end
    end
    stop='parents';
    if  regexpi(yuchu,stop)
        break
    end
end
skeleton=zeros(k,k);
%%%%%%%%%%%%%%%%%%%给节点命名%%%%%%%%%%%%%%%%%
j=0;
frewind(fid)
while ~feof(fid)
    tline=fgets(fid);% 从文件读入一行文本（不含回车键）
    tline= strrep(tline,'''','');
    [~,n]=size(tline);
    pipei=tline(1,1:end);
    stop='parents';
    if  regexpi(pipei,stop)
        break
    end
    if n>=4
        yuchu=tline(1,1:end);
        pa='v.*\(';
        out=regexp(yuchu,pa,'match');
        if ~isempty(out)
            j=j+1;
            A= char(out);
            A(A=='(') =[];
            A=strrep(A,' ','');
            names{j}=strrep(A,'var','');
        end
    end
end

%%%%%%%%%%%%%%%%%%%%生成sketelon结果%%%%%%%%%%%%%%%%%
frewind(fid)
while ~feof(fid)
    tline=fgets(fid);% 从文件读入一行文本（不含回车键）
    tline= strrep(tline,'''','');
    [~,n]=size(tline);
    
    if n>=2
        yuchu=tline(1,2:end);
        p='parents';
        if regexpi(yuchu,p)
            pa='\(.*\w';
            A=regexp(yuchu,pa,'match');
            A=strrep(A,'(','');
            A= regexp(A,'\s+','split');
            if ~isempty(A)
                A=A{1};
            end
            pa='parents.*?\(';
            B=regexp(yuchu,pa,'match');
            B=strrep(B,'parents','');
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
% graphViz4Matlab('-adjMat',skeleton,'-nodeLabels',names,'-layout',Treelayout)
end

