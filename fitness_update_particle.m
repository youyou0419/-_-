function [partical_fitness] = fitness_update_particle(population_size,partical_fitness,map_path,request_bandwidth_source)
%Ϊ����Ҫ������Ӹ�����������Ӧ��
for i=1:population_size
    if partical_fitness(i,:)~=inf
        partical_fitness(i,:)=(length(map_path{i,1})-1)*request_bandwidth_source;
    end
end
end

