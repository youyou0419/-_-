function [connectivity_status,map_path,map_path_status] = judge_direct_link(pso_particles,partical_fitness,population_size,network_request,index)
%connectivity_status����Ҫ����Ϊ���Ƕ����vnf�Ľڵ�ֱ����������ô�Ͳ���ʹ�����·�����������ˣ������������
%   �жϵ�ǰ��ӳ�䷽���У���ʹ������·���㷨��������ӳ����vnf�Ľڵ��Ƿ�������������غ㣬�������������ӵ�map_path��
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
end

