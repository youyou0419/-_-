function y=pso(index)
global  real_time_computing_resources real_time_bandwidth_resources real_time_task_status network_request UAV_node UAV_lianjie_matrix request_deployment_scheme ;
%% ���ó�ʼ����
population_size=5;
%������Ⱥ����
maximum_iterations=20;
%��������������
%% ��ʼ������Ⱥ ÿ���������ʼ�ڵ����սڵ�ȷ���ˣ����񳤶�Ҳ��
pso_particles=[];
for i=1:population_size
         pso_particles(i,:)=generate_particles(index);
         while length(pso_particles(i,:))~=length(unique(pso_particles(i,:)))%������ʵ��������������Ϊ��������randperm�����Ͳ��������ظ���Ԫ��
                 pso_particles(i,:)=generate_particles(index);  
            end
end
%% ��ʼ���ٶȲ�����������߱������Ƕ����Ʊ�����1��ʾ���ٴ�ѡ��0��ʾ��Ҫ�ӵײ�ڵ��ٴ�ѡ��
pso_velocity=[];
for i=1:population_size
    pso_velocity(i,:)=generate_velocity(index);
end
%% �����������ӵ���Ӧ��
%% ����˽ڵ��Ƿ������Դ ����������ֱ�Ӿܾ�����
yuanjiedian_index=network_request{1,2}(index,1);
duanjiedian_index=network_request{1,2}(index,2);
yuanjiedian_keyongziyuan=real_time_computing_resources(yuanjiedian_index);
duanjiedian_keyongziyuan=real_time_computing_resources(duanjiedian_index);
yuanjiedian_qingqiuziyuan=network_request{1,4}(index,1);
duanjiedian_qingqiuziyuan=network_request{1,4}(index,network_request{1,3}(index,1));
if  yuanjiedian_keyongziyuan <yuanjiedian_qingqiuziyuan
    real_time_task_status(index,1)=0;
    return;
end
if  duanjiedian_keyongziyuan<duanjiedian_qingqiuziyuan
    real_time_task_status(index,1)=0;
    return;
end     
%% �жϳ���Դ�Ͷ˽ڵ������ӳ��ڵ��Ƿ����������ԴԼ�� ��������㽫�����ӵ���Ӧ�ȼ�Ϊ����
partical_fitness=[];
for i=1:population_size
    for j=2:(network_request{1,3}(index,1)-1)
        if real_time_computing_resources(pso_particles(i,j))<network_request{1,4}(index,j)
            partical_fitness(i,1)=inf;
        end
        partical_fitness(i,1)=0;
    end
end
%% �����·����Ϊ������ӳ��·��
%% �ȱȽϵ�ǰ���ӵ�ӳ�䷽���Ƿ�������ͨ��,������ͨ�ԣ�ֱ�ӽ�pso_particles��ӵ�ӳ��·��������������һ��Ϊ��Ѱ�����·��
map_path={};
map_path_status=[];%1��ʾ�����Ѿ�����·��ӳ�䷽����0��ʾ���ӻ�δ��·��ӳ�䷽��
connectivity_status=[];
for i=1:population_size%ѡ��һ������
    if partical_fitness(i,1)==0%ӳ�䷽���Ľڵ�������ԴԼ��
       for j=1:(network_request{1,3}(index,1)-1)%����j����
           connectivity_status(i,j)=check_connection(pso_particles(i,j),pso_particles(i,j+1));
       end
       if all(connectivity_status(i,:) == 1)%���������������ֱ����Ϊӳ����·
           map_path{i,1}=pso_particles(i,:);
           map_path_status(i,1)=1;
       else
           map_path_status(i,1)=0;
       end
    
    end
end
%% Ϊ����������·�������ӣ�ʹ������Ⱥ�㷨Ϊ���������·��
for i=1:population_size
     linshi_lujing=[];
    if partical_fitness(i,1)==0
    if map_path_status(i,1)==0
        linshi_lujing=[];
        linshi_lujing=pso_particles(i,1);
        for j=1:(network_request{1,3}(index,1)-1)%����j����
            if connectivity_status(i,j)==0
                a=[];
               a=bfs(UAV_lianjie_matrix,pso_particles(i,j),pso_particles(i,j+1));
               a(1)=[];
               linshi_lujing=[linshi_lujing a];
            else
               linshi_lujing=[linshi_lujing pso_particles(i,j+1)];
            end
        end  
    end
    end
      map_path{i,1}=linshi_lujing;
      map_path_status(i,1)=1;
end
%% ��������ԴԼ�� ���������·�ϵĴ�����ԴС������Ĵ�����Դ����Ӧ������Ϊ����
request_bandwidth_source=network_request{1,5}(index,1);
for i=1:population_size
    if partical_fitness(i,:)~=inf
         test_link_source_path=[];
        test_link_source_path=map_path{i,1};
        for j=1:(length(test_link_source_path)-1)
            if real_time_bandwidth_resources(test_link_source_path(j), test_link_source_path(j+1))<request_bandwidth_source
                partical_fitness(i,:)=inf;
                break;
            end
        end
    end
end
%% ���ʱ��Լ���������ʱ�ӳ�����Ҫ���ʱ�ӣ��ܾ���������ʱ��Ϊ���㣬���ó�·������
for i=1:population_size
    if partical_fitness(i,:)~=inf
        if length(map_path{i,1})>network_request{1,9}(index,1)
             partical_fitness(i,:)=inf;
        end
    end
end
%% ������Ҫ������ӣ���������Ӧ��
for i=1:population_size
    if partical_fitness(i,:)~=inf
        partical_fitness(i,:)=(length(map_path{i,1})-1)*request_bandwidth_source;
    end
end
%% ��¼ȫ����������λ�ú͸�����������λ�� ���Ի��׶�
best_person_weizhi=[];
best_person_fitness=[];
best_gruop_weizhi=[];
best_gruop_fitness=[];
best_map_path=[];
[best_person_weizhi,best_person_fitness,best_gruop_weizhi,best_gruop_fitness,best_map_path] = intial_best(pso_particles,partical_fitness,population_size,map_path);
%% �����Ⱥ�ĳ��Ի������濪ʼ���е�����ѡ�����ŵ�ӳ�䷽��
counter=0;
while counter<maximum_iterations
    %% ������Լ�������ӽ���λ�ø��¡��ٶȸ���,����ν�������滹Ҫ�Բ��������������ӽ�����������
    %% ���ٶȽ��и���
    %% ��Ⱥ����������Ⱥ�ļ���
      v_3=[];
     [v_3] = update_group_sudu(pso_particles,best_gruop_weizhi,population_size);
    %% ��������������Ⱥ����
       v_2=[];
      [v_2] = update_person_sudu(pso_particles,best_person_weizhi);
    %% �ܵ��ٶȸ��º���
    [pso_velocity] = update_sudu(pso_velocity,v_2,v_3,population_size,network_request{1,3}(index));
    %% ��λ�ý��и���,�����и��£����ڲ����������ĸ��º�����ѡȡ�Ͳ�����ֱ��ѡȡûʲô����
    [pso_particles] = update_particle(pso_particles,pso_velocity,population_size,network_request,index,UAV_node);
    %% �Բ��������������������������ӵ�λ�ú��ٶȲ���,����Ҫ���������������Դ�ڵ�Ͷ˽ڵ���������Ҫ������ֶ��vnfӳ����һ���ڵ��ϵ����
    for i=1:population_size
        if partical_fitness==inf
            pso_particles(i,:)=generate_particles(index);  
            while length(pso_particles(i,:))~=length(unique(pso_particles(i,:)))
                 pso_particles(i,:)=generate_particles(index);  
            end
            pso_velocity(i,:)=generate_velocity(index);
        end
    end
     %% �������ӵ���Ӧ�ȣ�������Ⱥ���ţ��͸�������
     %% �жϳ���Դ�˽ڵ�����ڵ����ԴԼ����������Ⱥ��Ӧ�ȣ�
     [partical_fitness] = fitness_update_computing(pso_particles,partical_fitness,network_request,index,population_size);
     %% �жϲ�ʹ��bfs�㷨����·������ԭʼ������ӳ�䷽���Ƿ�����������ӳ��vnf�Ľڵ�����ֱ������һ��ͨ·��������������·��ӳ�䷽��map_path
     [connectivity_status,map_path,map_path_status] = judge_direct_link(pso_particles,partical_fitness,population_size,network_request,index);
     %% Ϊ������ֱ����ͨ�����ӷ�����ʹ�ù�����������㷨��Ϊ������·��ӳ�䷽��
     map_path_status(map_path_status==1)=0;
     [map_path,map_path_status] = create_mapping_link(connectivity_status,network_request,pso_particles,partical_fitness,map_path_status,population_size,index);
      %% �ж���·������ԴԼ�����������������������������������fitness�������������Ϊinf�������������һ��û�и���connectivity_status�������еĽڵ�֮���û��ʹ��·�����������½ڵ㲻����
    [partical_fitness] = fitness_update_bandwidth(map_path,partical_fitness,network_request,index,population_size);
      %% ���ʱ��Լ������������ϣ�����Ӧ������Ϊinf
      [ partical_fitness] = fitness_update_delay(partical_fitness,population_size,network_request,index,map_path);
      %% ������Լ�������ӣ���������Ӧ�ȣ���Ϊӳ�䷽��ռ�ô�����Դ���
      [partical_fitness] = fitness_update_particle(population_size,partical_fitness,map_path,request_bandwidth_source);
      %% ����ȫ�����ź͸�������λ�ú���Ӧ��,����¼����·��
      [best_gruop_weizhi,best_gruop_fitness,best_person_weizhi,best_person_fitness,best_map_path] = update_best(best_gruop_weizhi,best_gruop_fitness,best_person_weizhi,best_person_fitness,population_size,partical_fitness,pso_particles,map_path,best_map_path);
%% ���Ƶ�������

counter=counter+1;

end

      %% ��������ӳ�䷽������������ִ��״̬������ʵʱ�ڵ�����������ʵʱ������Դ,������һ������ӳ�䷽����·��
       %   �����Ѿ��ɹ������ӳ�䷽�������������Ӧ��Ϊ�����ô�����ܾ��������������Ӧ�Ȳ�Ϊinf���ʾ���ܸ÷�������

        %% ��������״̬
        if best_gruop_fitness~=inf
            real_time_task_status(index,1)=1;
          
            request_deployment_scheme{index,1}=best_gruop_weizhi;
              request_deployment_scheme{index,2}=best_map_path;
        else 
            real_time_task_status(index,1)=0;
              request_deployment_scheme{index,1}=[];
              request_deployment_scheme{index,2}=[];
        end
        %% ����ʵʱ������Դ
        if real_time_task_status(index,1)==1
       real_time_computing_resources=resource_computing_update(best_gruop_weizhi,real_time_computing_resources,network_request,index);
        end
        %% ����ʵʱ������Դ
        if real_time_task_status(index,1)==1
       [real_time_bandwidth_resources] = resource_bandwidth_update(real_time_bandwidth_resources,request_bandwidth_source,best_map_path);
        end
        
        
            
            
       
       
       
       
       
end

