%% ���������������������ӣ����һ����������5�����ӣ����ӵĵ�һ��λ�ú����һ��λ�ö��������趨���˵ģ��м�ʣ�µ�����vnf������䲻ͬ��λ��
function y=generate_particles(index)
%����ѡ������Ӳ������ܺ�start_node��end_node�ظ���Ҳ���ܺ�����Ԫ���ظ�
global  network_request UAV_node;
    start_node=network_request{1,2}(index,1) ;
    end_node=network_request{1,2}(index,2);
 a=[];
    panduan1=1;
    panduan2=1;
    while xor(1,isempty(panduan2))||xor(1,isempty(panduan1))
       a=randperm(UAV_node,network_request{1,3}(index,:)-2);
       panduan1=find(a== start_node);
       panduan2=find(a== end_node);
    end
    y=[start_node a end_node];
end
    
    