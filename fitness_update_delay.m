function [ partical_fitness] = fitness_update_delay(partical_fitness,population_size,network_request,index,map_path)
%���ӳ�䷽����ʱ��Լ��������·�ĳ��ȵ���ʱ�ӣ�
for i=1:population_size
    if partical_fitness(i,:)~=inf
        if length(map_path{i,1})>network_request{1,9}(index,1)
             partical_fitness(i,:)=inf;
        end
    end
end
end

