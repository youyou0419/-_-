function [partical_fitness] = fitness_update_computing(pso_particles,partical_fitness,network_request,index,population_size)
%FITNESS_UPDATE_COMPUTING �˴���ʾ�йش˺�����ժҪ
%   �����ж����ɵ�����ӳ�䷽�����г���Դ�ڵ�Ͷ˽ڵ�����Ľڵ��Ƿ����������ԴԼ������������㣬��Ӧ������Ϊ���������Ӧ������Ϊ0
global  real_time_computing_resources;
partical_fitness=[];
for i=1:population_size
    for j=2:(network_request{1,3}(index,1)-1)
        if real_time_computing_resources(pso_particles(i,j))<network_request{1,4}(index,j)
            partical_fitness(i,1)=inf;
        end
        partical_fitness(i,1)=0;
    end
end
end

