function [best_gruop_weizhi,best_gruop_fitness,best_person_weizhi,best_person_fitness,best_map_path] = update_best(best_gruop_weizhi,best_gruop_fitness,best_person_weizhi,best_person_fitness,population_size,partical_fitness,pso_particles,map_path,best_map_path)
%��Ӧ�ȸ���ȫ���������Ӻ�ȫ��������Ӧ�ȣ�������������Ⱥ�͸���������Ӧ��

%% ��������ȫ��λ�ú���Ӧ��
for i=1:population_size
    if partical_fitness(i,1)<best_gruop_fitness
        best_gruop_fitness=partical_fitness(i,1);
        best_gruop_weizhi=pso_particles(i,:);
        best_map_path=map_path{i,:};
    end
end
%% ����������Ӧ�ȸ���λ�ú���Ӧ��
for i=1:population_size
    if partical_fitness(i,1)<best_person_fitness(i,1)
        best_person_fitness(i,1)=partical_fitness(i,1);
        best_person_weizhi(i,:)=pso_particles(i,:);
    end
end





end

