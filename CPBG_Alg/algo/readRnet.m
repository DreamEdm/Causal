function [skeleton,names2] = readRnet(file)
fid=fopen(file);
%%%%%%%%%%%%%%%%%%%%��Ҫ�ڵ�������ʼ��skeleton%%%%%%%%%%%%%%%%%
k=0;
while ~feof(fid)
    tline=fgets(fid);% ���ļ�����һ���ı��������س�����
    tline= strrep(tline,'''','');
    if ~isempty(tline) % �ж��Ƿ����
        [~,n]=size(tline);
        if n>=4
            yuchu = tline(1,1:end);
            pi=yuchu(1,1:4);
            if strcmp(pi,'node')==1
                k=k+1;
            end
        end
    end
    stop='potential';
    if  regexpi(yuchu,stop)
        break
    end
end
skeleton=zeros(k,k);
%%%%%%%%%%%%%%%%%%%���ڵ�����%%%%%%%%%%%%%%%%%
j=0;
frewind(fid) %ָ���Ƶ�ǰͷ
while ~feof(fid)
    tline=fgets(fid);% ���ļ�����һ���ı��������س�����
    tline= strrep(tline,'''','');
    [~,n]=size(tline);
    pipei=tline(1,1:end);
    stop='potential';
    if  regexpi(pipei,stop)
        break
    end
    if n>=4
        yuchu=tline(1,1:end);
        pa='node.*';
        out=regexp(yuchu,pa,'match');
        if ~isempty(out)
            j=j+1;
            A = char(out);
            A=strrep(A,' ','');
            A=strrep(A,' ','');
            A=strrep(A,' ','');
            names{j}=strrep(A,'node','');
        end
    end
end
for k = 1:size(names,2)
    names2{k} = names{k}(1:end-1);
end
%%%%%%%%%%%%%%%%%%%����sketelon���%%%%%%%%%%%%%%%%%
frewind(fid)
while ~feof(fid)
    tline=fgets(fid);% ���ļ�����һ���ı��������س�����
    tline= strrep(tline,'''','');
    [~,n]=size(tline);
    
    if n>=2
        yuchu=tline(1,1:end);
        p='potential';
        if regexpi(yuchu,p)
            pa='\|.*\w';
            A=regexp(yuchu,pa,'match');
            A=strrep(A,'| ','');
            A= regexp(A,'\s+','split');
            if ~isempty(A)
                A=A{1};
            end
            pa='potential.*\|';
            B=regexp(yuchu,pa,'match');
            B=strrep(B,'potential','');
            B=strrep(B,'(','');
            B=strrep(B,' ','');
            B=strrep(B,'|','');
            len=length(A);
            for n=1:len
                if ~isempty(A{n})
                    inda=strcmp(names2,A{n});
                    f= inda==1;
                    indb=strcmp(names2,B);
                    z= indb==1;
                    skeleton(f,z)=1;
                end
            end
        end
    end
end
fclose(fid);
end