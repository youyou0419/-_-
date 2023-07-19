%% д�����ر����д���
clear;
%������չ������ڴ�
clc;
%������������д���
close all;
%�ر����е�figure��ͼ��
clear global;
%�������ȫ�ֱ���
%% ����ȫ�ֱ��� �����ڵ����Ӻ���ʱ����ɾ�����ڴ�����
global  real_time_computing_resources real_time_bandwidth_resources real_time_task_status network_request UAV_node UAV_lianjie_matrix request_deployment_scheme ;
%% ����һ�����˻���������
UAV_node=27;
%���˻������е����˻���Ŀ
UAV_node_zuobiao=[  0.27,0.4;0.72,0.8;0.25,0.6;
                    0.7,0.2;0.6,0.3;0.795,0.52;
                    0.3, 0.31;0.32,0.5;0.3,0.7;
                    0.4,0.2;0.4,0.39;0.4,0.6;
                    0.4,0.8;0.5,0.3;0.56,0.7;
                    0.6,0.42;0.6,0.2; 0.6,0.6;
                    0.6,0.8;0.76,0.3;0.7,0.7;
                    0.8,0.4;0.7,0.5;0.75,0.6;
                    0.4,0.72;0.48,0.45;0.5,0.2;];
%�ֶ�����˽ڵ��λ�ã�UAV_node_zuobiao��һ��27��2�ľ��󣬹���27�У�ÿһ�д���һ�����˻�����һ���������꣬�ڶ����Ǻ�����
UAV_lianjie_matrix = zeros(UAV_node);
%��ʼ�����˻��ڵ�֮������Ӿ�����һ��27��27�ľ���
max_distance=0.2;
%���������룬����������Ľڵ�֮�䲻��ͨ���ɴ����������˻��ڵ�֮�����·
for i=1:UAV_node
    for j=i+1:UAV_node
        distance=pdist([UAV_node_zuobiao(i,:); UAV_node_zuobiao(j,:)], 'euclidean');
        if distance<max_distance
            UAV_lianjie_matrix(i,j)=1;
            UAV_lianjie_matrix(j,i)=1;    
        end
    end
end
%���������˻��ڵ�֮�����ͨ�Ծ���
%gplot( UAV_lianjie_matrix,UAV_node_zuobiao,'-o');
%�������˻��ڵ����������ͼ
%% ���ü�����Դ��������Դ��ʱ�Ӵ�С
UAV_computing_resources=[];
for i=1:UAV_node
    UAV_computing_resources(i,:)=50+round(50*rand);
end
%Ϊÿ�����˻��ڵ��������Դ��ֵ50~100
UAV_band_resources=UAV_lianjie_matrix;
for i=1:UAV_node
    for j=i+1:UAV_node
        if UAV_band_resources(i,j)==1
               UAV_band_resources(i,j)=50+round(50*rand);
               UAV_band_resources(j,i)=UAV_band_resources(i,j);
        end
    end
end
%Ϊÿ����·�����˴�����Դ�ĸ�ֵ50~100
% UAV_link_delay=UAV_lianjie_matrix;
% for i=1:UAV_node
%     for j=i+1:UAV_node
%         if UAV_link_delay(i,j)==1
%                UAV_link_delay(i,j)=round(100*pdist([UAV_node_zuobiao(i,:); UAV_node_zuobiao(j,:)], 'euclidean'));
%                UAV_link_delay(j,i)=UAV_link_delay(i,j);
%         end
%     end
% end
% %��������·�ϵ�ʱ��
%% ���������������� ����1.���2.��ʼ����ڵ�3.����4.ÿ��vnf�������Դ��С5.����Լ��6.�������ʱ��7.���񵽴�ʱ��8.�������ʱ��9.���ʱ��Ҫ��
network_request={};


request_arrival_time=[];
lambda = 5; % ���ò��ɷֲ��Ĳ���
num_values = 500; % Ҫ���ɵ������������,������50��������1000��ʱ�䵥λ��
poisson_values = random('Poisson', lambda, 1, num_values); % ���ɷ��Ӳ��ɷֲ��������
request_num=sum(poisson_values);
for i=1:num_values
    for j=1:poisson_values(i)
    request_arrival_time(end+1,1)=(i-1)*100+round(100*rand);
    end
end
request_arrival_time=sort(request_arrival_time,1);
%���������������������񵽴�ʱ��
network_request{1,7}=request_arrival_time;


request_duration=200;
starting_ending_nodes=[];
for i=1:request_num
    starting_ending_nodes(i,:)=randperm(UAV_node,2); 
end
network_request{1,2}=starting_ending_nodes;
%��������ʼ����ڵ�
for i=1:request_num
    request_length(i,:)=3+round(7*rand); 
end
network_request{1,3}=request_length;
%���������񳤶ȣ�����3~10�ľ��ȷֲ�
request_VNF_resources=[];
for i=1:request_num
    for j=1:request_length(i)
    request_VNF_resources(i,j)=15+round(10*rand); 
    end
end
network_request{1,4}=request_VNF_resources;
%������ÿ�����������й�ÿ��vnf������ļ�����Դ��С5~15
for i=1:request_num
    request_bandwidth_resources(i,:)=5+round(10*rand); 
end
network_request{1,5}=request_bandwidth_resources;
%������ÿ������������ÿ��������·Ҫ��Ĵ�����Դ5~15
network_request{1,6}=request_duration;
%������ÿ������ĳ���ʱ��

request_index=[];
for i=1:request_num
    request_index(i,:)=i;
end
network_request{1,1}=request_index;
%��������б��

request_end_time=request_arrival_time+request_duration;
network_request{1,8}=request_end_time;


%% Ϊ�����������ʱ��Ҫ�� 

request_max_delay=[];
for i=1:request_num
    request_max_delay(i,1)=20+round(5*rand);
end
network_request{1,9}=request_max_delay;

%% ������������ܣ�����
request_total=zeros(request_num,9);
request_total(:,1)=request_index;


%% ��ʼִ������ ÿ�����񵽴�ͽ���һ������Ⱥ����ʱ�䵽�����ͷſռ�
total_time=[];
t=0;
real_time_computing_resources=UAV_computing_resources;
%��¼ʵʱ��Դ״̬
real_time_bandwidth_resources=UAV_band_resources;
%��¼ʵʱ������Դ״̬
request_deployment_scheme={};
request_deployment_scheme=cell(request_num,2);
%������������ �ܾ���������������������
 temp_1=[];  temp_total=[];x_axis=[]; request_accept_ratio=[];
while   t~=(request_end_time(end,1)+1)
    
    index=[];
    index=find(request_arrival_time==t);
    if length(index)==1
       pso(index);
    end
    if length(index)>1%��ӳ�䳤�ȴ���
    for i=1:length(index)
        pso(index(i,1));
    end
    end
   %% ���ʱ�䵽�������ֹʱ���ͷż�����Դ,������Դ������ʵʱ������Դ,
if xor(1,isempty(find(t==request_end_time)))
    index_update=find(t==request_end_time);
    if length(index_update)==1
      [real_time_computing_resources]=resource_computing_release(request_deployment_scheme{index_update,1},real_time_computing_resources,network_request,index_update);
      [real_time_bandwidth_resources] = resource_bandwidth_release(real_time_bandwidth_resources,network_request{1,5}(index_update,1),request_deployment_scheme{index_update,2});
    end
    if length(index_update)>1
        for j=1:length(index_update)
      [real_time_computing_resources]=resource_computing_release(request_deployment_scheme{index_update(j,1),1},real_time_computing_resources,network_request,index_update(j,1));
      [real_time_bandwidth_resources] = resource_bandwidth_release(real_time_bandwidth_resources,network_request{1,5}(index_update(j,1),1),request_deployment_scheme{index_update(j,1),2});
        end
    end
      
end
%% ͳ�����������
 for i=4:46
          if t==(1000*i)
              temp_1=length(find(real_time_task_status==1));
            
              temp_total=length(real_time_task_status);
              request_accept_ratio(1,end+1)=temp_1/temp_total;
              x_axis(1,end+1)=i;
          end
 end
              
t=t+1;
end
 1;
 %% ͳ�����������
plot(x_axis,request_accept_ratio);
title('�����������������');
xlabel('ʱ��/1000ʱ�䵥Ԫ');
ylabel('���������');

    
 
 
   
        
          
 