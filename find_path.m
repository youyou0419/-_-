function []=find_path(A,nodeNum)

A=  UAV_lianjie_matrix;          % �����ڽӾ���
[m n]=size(A);
nodeNum=UAV_node;                       % �ڵ���
vflag=zeros(nodeNum,1);          % ��ʼ�����нڵ���ʱ�־λ
queue=[];                        % ����������У�ÿ�η��ʲ���������
result=[];                       % �������
startNode=1;%unidrnd(nodenum);   % ������ڵ����
queue=[queue;startNode];         % ���±����������
vflag(startNode)=1;              % ���·��ʱ�־
result=[result;startNode];       % ���±����������
% while isempty(queue)==false
while all(vflag)==0
    i=queue(1);
    queue(1)=[];
    for j=1:n
        if(A(i,j)>0&&vflag(j)==0&&i~=j)
            queue=[queue;j];
            vflag(j)=1;
            result=[result;j];
        end
    end
end